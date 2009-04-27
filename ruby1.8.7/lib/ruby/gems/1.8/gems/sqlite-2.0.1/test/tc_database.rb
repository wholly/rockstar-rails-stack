#--
# =============================================================================
# Copyright (c) 2004, Jamis Buck (jgb3@email.byu.edu)
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
# 
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
# 
#     * The names of its contributors may not be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# =============================================================================
#++

$:.unshift "lib"

require 'sqlite'
require 'test/unit'

class TC_Database < Test::Unit::TestCase

  def setup
    @db = SQLite::Database.open( "db/fixtures.db" )
  end

  def teardown
    @db.close
  end

  def test_execute_no_block
    rows = @db.execute( "select * from A order by name limit 2" )

    assert_equal [ [nil, "6"], ["Amber", "5"] ], rows
  end

  def test_execute_with_block
    expect = [ [nil, "6"], ["Amber", "5"] ]
    @db.execute( "select * from A order by name limit 2" ) do |row|
      assert_equal expect.shift, row
    end
    assert expect.empty?
  end

  def test_execute2_no_block
    columns, *rows = @db.execute2( "select * from A order by name limit 2" )

    assert_equal [ "name", "age" ], columns
    assert_equal [ [nil, "6"], ["Amber", "5"] ], rows
  end

  def test_execute2_with_block
    expect = [ ["name", "age"], [nil, "6"], ["Amber", "5"] ]
    @db.execute2( "select * from A order by name limit 2" ) do |row|
      assert_equal expect.shift, row
    end
    assert expect.empty?
  end

  def test_bind_vars
    rows = @db.execute( "select * from A where name = ?", "Amber" )
    assert_equal [ ["Amber", "5"] ], rows
    rows = @db.execute( "select * from A where name = ?", 15 )
    assert_equal [], rows
  end

  def test_result_hash
    @db.results_as_hash = true
    rows = @db.execute( "select * from A where name = ?", "Amber" )
    assert_equal [ {"name"=>"Amber", 0=>"Amber", "age"=>"5", 1=>"5"} ], rows
  end

  def test_result_hash_types
    @db.results_as_hash = true
    rows = @db.execute( "select * from A where name = ?", "Amber" )
    assert_equal [ "VARCHAR(60)", "INTEGER" ], rows[0].types
  end

  def test_query
    @db.query( "select * from A where name = ?", "Amber" ) do |result|
      row = result.next
      assert_equal [ "Amber", "5"], row
    end
  end

  def test_metadata
    @db.query( "select * from A where name = ?", "Amber" ) do |result|
      assert_equal [ "name", "age" ], result.columns
      assert_equal [ "VARCHAR(60)", "INTEGER" ], result.types
      assert_equal [ "Amber", "5"], result.next
    end
  end

  def test_get_first_row
    row = @db.get_first_row( "select * from A order by name" )
    assert_equal [ nil, "6" ], row
  end

  def test_get_first_value
    age = @db.get_first_value( "select age from A order by name" )
    assert_equal "6", age
  end

  def test_create_function
    @db.create_function( "maim", 1 ) do |func, value|
      if value.nil?
        func.set_result nil
      else
        func.set_result value.split(//).sort.join
      end
    end

    value = @db.get_first_value( "select maim(name) from A where name='Amber'" )
    assert_equal "Abemr", value
  end

  def test_create_aggregate
    step = proc do |func, value|
      func[ :total ] ||= 0
      func[ :total ] += ( value ? value.length : 0 )
    end

    finalize = proc do |func|
      func.set_result( func[ :total ] || 0 )
    end

    @db.create_aggregate( "lengths", 1, step, finalize )

    value = @db.get_first_value( "select lengths(name) from A" )
    assert_equal "33", value
  end

  def test_context_on_nonaggregate
    @db.create_function( "barf1", 1 ) do |func, value|
      func['hello']
    end

    @db.create_function( "barf2", 1 ) do |func, value|
      func['hello'] = "world"
    end

    @db.create_function( "barf3", 1 ) do |func, value|
      func.count
    end

    assert_raise( SQLite::Exceptions::MisuseException ) do
      @db.get_first_value( "select barf1(name) from A where name='Amber'" )
    end

    assert_raise( SQLite::Exceptions::MisuseException ) do
      @db.get_first_value( "select barf2(name) from A where name='Amber'" )
    end

    assert_raise( SQLite::Exceptions::MisuseException ) do
      @db.get_first_value( "select barf3(name) from A where name='Amber'" )
    end
  end

  class LengthsAggregate
    def self.function_type
      :numeric
    end

    def self.arity
      1
    end

    def self.name
      "lengths"
    end

    def initialize
      @total = 0
    end

    def step( ctx, name )
      @total += ( name ? name.length : 0 )
    end

    def finalize( ctx )
      ctx.set_result( @total )
    end
  end

  def test_create_aggregate_handler
    @db.create_aggregate_handler LengthsAggregate

    result = @db.get_first_value( "select lengths(name) from A" )
    assert_equal "33", result
  end

  def test_prepare
    stmt = @db.prepare( "select * from A" )
    assert_equal "", stmt.remainder
    assert_equal [ "name", "age" ], stmt.columns
    assert_equal [ "VARCHAR(60)", "INTEGER" ], stmt.types
    stmt.execute do |result|
      row = result.next
      assert_equal [ "Zephyr", "1" ], row
    end
  end

  def test_execute_all
    queries = 0
    @db.execute_all( "select * from A; " +
                     "select * from A where name='Amber'; " +
                     "select distinct age from A" ) do |row|
      queries += 1 if queries == 0 || row.nil?
      next if row.nil?
    end
    assert_equal 3, queries

    queries = 0
    @db.execute_all( %q{--- query number one
                        select * from A;
                        /* query number
                         * two */
                        select * from A where name='Amber';
                       select distinct /* comment here */ age from A} ) do |row|
      queries += 1 if queries == 0 || row.nil?
      next if row.nil?
    end
    assert_equal 3, queries
  end

end
