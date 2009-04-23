# et:ts=4
# porttest.tcl
# $Id: porttest.tcl 26177 2007-06-15 10:11:22Z jmpp@macports.org $

package provide porttest 1.0
package require portutil 1.0

set org.macports.test [target_new org.macports.test test_main]
target_provides ${org.macports.test} test
target_requires ${org.macports.test} main fetch extract checksum patch configure build
target_prerun ${org.macports.test} test_start

# define options
options test.run test.target 
commands test

# Set defaults
default test.dir {${build.dir}}
default test.cmd {${build.cmd}}
default test.pre_args {${test.target}}
default test.target test

set_ui_prefix

proc test_start {args} {
    global UI_PREFIX portname
    ui_msg "$UI_PREFIX [format [msgcat::mc "Testing %s"] ${portname}]"
}

proc test_main {args} {
    global portname test.run
    if {[tbool test.run]} {
    	command_exec test
    } else {
	return -code error [format [msgcat::mc "%s has no tests turned on. see 'test.run' in portfile(7)"] $portname]
    }
    return 0
}
