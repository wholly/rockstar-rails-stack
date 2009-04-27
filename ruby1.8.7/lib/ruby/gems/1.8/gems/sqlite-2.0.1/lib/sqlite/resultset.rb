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

require 'sqlite_api'

module SQLite

  # The ResultSet object encapsulates the enumerability of a query's output.
  # It is a simple cursor over the data that the query returns. It will
  # very rarely (if ever) be instantiated directly. Instead, client's should
  # obtain a ResultSet instance via Statement#execute.
  class ResultSet
    include Enumerable

    # A trivial module for adding a +types+ accessor to an object.
    module TypesContainer
      attr_accessor :types
    end

    # A trivial module for adding a +fields+ accessor to an object.
    module FieldsContainer
      attr_accessor :fields
    end

    # Create a new ResultSet attached to the given database and virtual
    # machine instances.
    def initialize( db, sql )
      @db = db
      @sql = sql
      @vm, rest = API.compile( @db.handle, @sql )
    end

    # Close the result set. Attempting to perform any operation (including
    # #close) on a closed result set will have undefined results.
    def close
      API.finalize( @vm )
    end

    # Reset the cursor, so that a result set which has reached end-of-file
    # can be rewound and reiterated. _Note_: this uses an experimental API,
    # which is subject to change. Use at your own risk.
    def reset
      API.finalize( @vm )
      @vm, rest = API.compile( @db.handle, @sql )
      @eof = false
    end

    # Query whether the cursor has reached the end of the result set or not.
    def eof?
      @eof
    end

    # Obtain the next row from the cursor. If there are no more rows to be
    # had, this will return +nil+. If type translation is active on the
    # corresponding database, the values in the row will be translated
    # according to their types.
    #
    # The returned value will be an array, unless Database#results_as_hash has
    # been set to +true+, in which case the returned value will be a hash.
    #
    # For arrays, the column names are accessible via the +fields+ property,
    # and the column types are accessible via the +types+ property.
    #
    # For hashes, the column names are the keys of the hash, and the column
    # types are accessible via the +types+ property.
    def next
      if @saved_row
        saved_row, @saved_row = @saved_row, nil
        return saved_row
      end

      return nil if @eof

      result = API.step( @vm )
      @columns = result[ :columns ] unless @columns
      @types = result[ :types ] unless @types

      if result.has_key?( :row )
        row = result[:row]

        if @db.type_translation
          row = @types.zip( row ).map do |type, value|
            @db.translator.translate( type, value )
          end
        end

        if @db.results_as_hash
          new_row = Hash[ *( result[:columns].zip( row ).flatten ) ]
          row.each_with_index { |value,idx| new_row[idx] = value }
          row = new_row
        else
          row.extend FieldsContainer unless row.respond_to?(:fields)
          row.fields = @columns
        end

        row.extend TypesContainer
        row.types = @types

        return row
      else
        @eof = true
        return nil
      end
    end

    # Required by the Enumerable mixin. Provides an internal iterator over the
    # rows of the result set.
    def each
      while row=self.next
        yield row
      end
    end

    # Return an array of the column names for this result set.
    def columns
      return @columns if @columns
      @saved_row = self.next
      return @columns
    end

    # Return an array of column types for this result set.
    def types
      return @types if @types
      @saved_row = self.next
      return @types
    end

  end

end
