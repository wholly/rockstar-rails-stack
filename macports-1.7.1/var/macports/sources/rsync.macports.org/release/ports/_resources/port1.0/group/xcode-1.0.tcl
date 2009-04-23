# -*- coding: utf-8; mode: tcl; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- vim:fenc=utf-8:filetype=tcl:et:sw=4:ts=4:sts=4
# xcode.tcl
#
# $Id: xcode-1.0.tcl 47758 2009-03-05 16:42:37Z jmr@macports.org $
#
# Copyright (c) 2005 Paul Guyot <pguyot@kallisys.net>,
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of Apple Computer, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived from
#    this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Group code for xcode-based ports.
# These includes applications and frameworks (or actually whatever you want
# that might usefully take advantage of the code below).
#
# base/ provides stuff prefixed with xcode without a dot:
# - extraction of xcode version to $xcodeversion
# - extraction of xcode/pbx command line tool to $xcodebuildcmd
#
# This group provides:
#  categories set to aqua
#  platforms set to macosx
#  use_configure set to no
#  build procedure
#  destroot procedure
#  build.cmd set to $xcodebuildcmd
#  build.args set to build
#  destroot.cmd set to $xcodebuildcmd
#  destroot.args set to install
#
# build and destroot parameters use the following parameters:
#  PortGroup specific parameters:
#   xcode.project            name (or path relative to build.dir) of the xcode
#                            project. Default is "" meaning let xcodebuild figure it
#                            out.
#   xcode.configuration      xcode buildstyle/configuration. Default is Deployment.
#   xcode.target             if present, overrides build.target and destroot.target
#   xcode.build.settings     additional settings passed to $xcodebuildcmd (in
#                            the X=Y form)
#   xcode.destroot.type      install type (application or framework). Default is
#                            application. This setting overrides xcode.destroot.path.
#   xcode.destroot.path      install path (INSTALL_PATH setting value).
#   xcode.destroot.settings  additional settings passed to $xcodebuildcmd (in
#                            the X=Y form)
#   xcode.universal.settings settings passed to $xcodebuildcmd when the +universal
#                            variant is selected. Defaults to ARCHS="${universal_archs}"
#                            MACOSX_DEPLOYMENT_TARGET=${universal_target}.
#   xcode.universal.sdk      sdk to use when the +universal variant is selected.
#                            Defaults to ${universal_sysroot}. If set to the empty
#                            list, no sdk option will be passed to xcodebuild.
#
#  Usual parameters:
#   destroot            where to destroot the project.
#   build.cmd           normally set to $xcodebuildcmd earlier.
#   build.target        xcode target(s) to build.
#   build.pre_args      additional parameters for xcodebuildcmd when building
#   build.args          normally set to build
#   build.post_args     additional parameters for xcodebuildcmd when building
#   build.dir           directory where to build the project (where xcode
#                       project is)
#   destroot.cmd        normally set to $xcodebuildcmd earlier.
#   destroot.target     xcode target(s) to install
#   destroot.pre_args   additional parameters for xcodebuildcmd when installing
#   destroot.args       normally set to install
#   destroot.post_args  additional parameters for xcodebuildcmd when installing
#   destroot.dir        directory where to run destroot command the project
#                       (where xcode project is)

# Options this group provides:
default categories          aqua
default platforms           macosx
default use_configure       no
default build.cmd           $xcodebuildcmd
default build.args          build
default build.pre_args      {}
default build.target        ""
default destroot.cmd        $xcodebuildcmd
default destroot.args       install
default destroot.pre_args   {}
default destroot.target     ""
default destroot.destdir    {DSTROOT="${destroot}"}

# Default values for parameters.
options xcode.project
default xcode.project ""
options xcode.target
default xcode.target ""
options xcode.configuration
default xcode.configuration Deployment
options xcode.build.settings
default xcode.build.settings ""
options xcode.destroot.type
default xcode.destroot.type "application"
options xcode.destroot.path
default xcode.destroot.path ""
options xcode.destroot.settings
default xcode.destroot.settings ""

options xcode.universal.settings
default xcode.universal.settings {ARCHS=\"${universal_archs}\"\ MACOSX_DEPLOYMENT_TARGET=${universal_target}}
options xcode.universal.sdk
default xcode.universal.sdk {${universal_sysroot}}

namespace eval xcode {}

# Some utility functions.
# get the project directory (where build/ is).
proc xcode::get_project_path {} {
    global xcode.project worksrcpath
    if {${xcode.project} == ""} {
        set suffix ""
    } else {
        set suffix [file dirname [join ${xcode.project}]]
    }
    return [file normalize [file join ${worksrcpath} ${suffix}]]
}

# fix resource dependencies (with Xcode >= 2.1).
proc xcode::fix_resource_dependencies {} {
    global xcodeversion xcode.configuration
    if {$xcodeversion == "2.1"} {
        set build_path "[xcode::get_project_path]/build/"
        set config_build_path "[xcode::get_project_path]/build/${xcode.configuration}/"
        if {[file isdirectory ${config_build_path}]} {
            foreach resource [glob "${config_build_path}*"] {
                set resource_name [file tail $resource]
                if {![file exists $build_path/$resource_name]} {
                    file link $build_path/$resource_name $config_build_path/$resource_name
                }
            }
        }
    }
}

# get the configuration/buildstyle argument.
proc xcode::get_configuration_arg { style } {
    global xcodeversion
    if {$style != ""} {
        if {$xcodeversion == "2.1"} {
            return "-configuration $style"
        } else {
            return "-buildstyle $style"
        }
    } else {
        return ""
    }
}

# get the project argument.
proc xcode::get_project_arg { project } {
    if {$project != ""} {
        return "-project \"[join $project]\""
    } else {
        return ""
    }
}

# get the install path setting
# remark: xcodebuild take care of creating the directory if required.
proc xcode::get_install_path_setting { path type } {
    global applications_dir frameworks_dir
    if {$path == ""} {
        if {$type == "application"} {
            return "INSTALL_PATH=${applications_dir}"
        } elseif {$type == "framework"} {
            return "INSTALL_PATH=${frameworks_dir}"
        } else {
            return ""
        }
    } else {
        return "INSTALL_PATH=\"$path\""
    }
}

# setup command line.
proc xcode::setup_command_line {command args settings} {
    global ${command}.dir ${command}.env ${command}.cmd ${command}.pre_args \
        ${command}.args ${command}.post_args

    # Check that xcode is installed.
    if {[set ${command}.cmd] == "none"} {
        return -code error "This port requires 'pbxbuild/xcodebuild', which \
    couldn't be found (not MacOS X?)"
    }

    set cmdstring ""
    if {[info exists ${command}.dir]} {
        set cmdstring "cd \"[set ${command}.dir]\" &&"
    }
    if {[info exists ${command}.env]} {
        foreach string [set ${command}.env] {
            set cmdstring "$cmdstring $string"
        }
    }
    if {[info exists ${command}.cmd]} {
        foreach string [set ${command}.cmd] {
            set cmdstring "$cmdstring $string"
        }
    } else {
        return -code error "No ${command}.cmd was specified"
    }
    if {[info exists ${command}.pre_args]} {
        foreach string [set ${command}.pre_args] {
            set cmdstring "$cmdstring $string"
        }
    }
    set cmdstring "$cmdstring $args"
    if {[info exists ${command}.args]} {
        foreach string [set ${command}.args] {
            set cmdstring "$cmdstring $string"
        }
    }
    set cmdstring "$cmdstring $settings"
    if {[info exists ${command}.post_args]} {
        foreach string [set ${command}.post_args] {
            set cmdstring "$cmdstring $string"
        }
    }
    ui_debug "Assembled command: '$cmdstring'"
    return $cmdstring
}

# build one target.
proc xcode::build_one_target {args settings} {
    set cmdstring [xcode::setup_command_line build $args $settings]
    system "$cmdstring"
}

# destroot one target.
proc xcode::destroot_one_target {args settings} {
    set cmdstring [xcode::setup_command_line destroot $args $settings]
    system "$cmdstring"
}

# build procedure.
build {
    # determine the targets.
    if {${xcode.target} != ""} {
        set xcode_targets ${xcode.target}
    } else {
        set xcode_targets ${build.target}
    }
    
    # set some arguments.
    set xcode_configuration_arg [xcode::get_configuration_arg ${xcode.configuration}]
    set xcode_project_arg [xcode::get_project_arg ${xcode.project}]
    set xcode_build_args "OBJROOT=build/ SYMROOT=build/"

    if {[variant_isset universal]} {
        set xcode_build_args "$xcode_build_args ${xcode.universal.settings}"
        if {"${xcode.universal.sdk}" != ""} {
            if {${os.major} >= 9} {
                set xcode_build_args "-sdk ${xcode.universal.sdk} $xcode_build_args"
            } else {
                set xcode_build_args "SDKROOT=\"${xcode.universal.sdk}\" $xcode_build_args"
            }
        }
    }
    
    # iterate on targets if there is any, do -alltargets otherwise.
    if {"$xcode_targets" == ""} {
        xcode::build_one_target \
            "$xcode_project_arg -alltargets $xcode_configuration_arg" \
            "$xcode_build_args ${xcode.build.settings}"
    } else {
        foreach target $xcode_targets {
            xcode::build_one_target \
                "$xcode_project_arg -target \"$target\" $xcode_configuration_arg" \
                "$xcode_build_args ${xcode.build.settings}"
        }
    }
}

# destroot procedure.
destroot {
    # let Xcode 2.1+ find resources.
    xcode::fix_resource_dependencies
    
    # determine the targets.
    if {${xcode.target} != ""} {
        set xcode_targets ${xcode.target}
    } else {
        set xcode_targets ${destroot.target}
    }
    
    # set some arguments.
    set xcode_configuration_arg [xcode::get_configuration_arg ${xcode.configuration}]
    set xcode_project_arg [xcode::get_project_arg ${xcode.project}]
    set xcode_install_path_setting [xcode::get_install_path_setting \
                                        ${xcode.destroot.path} ${xcode.destroot.type}]
    set xcode_build_args "OBJROOT=build/ SYMROOT=build/"
    
    if {[variant_isset universal]} {
        set xcode_build_args "$xcode_build_args ${xcode.universal.settings}"
        if {"${xcode.universal.sdk}" != ""} {
            if {${os.major} >= 9} {
                set xcode_build_args "-sdk ${xcode.universal.sdk} $xcode_build_args"
            } else {
                set xcode_build_args "SDKROOT=\"${xcode.universal.sdk}\" $xcode_build_args"
            }
        }
    }

    # iterate on targets if there is any, do -alltargets otherwise.
    if {"$xcode_targets" == ""} {
        xcode::destroot_one_target \
            "$xcode_project_arg -alltargets $xcode_configuration_arg" \
            "$xcode_install_path_setting $xcode_build_args ${xcode.destroot.settings}"
    } else {
        foreach target $xcode_targets {
            xcode::destroot_one_target \
                "$xcode_project_arg -target \"$target\" $xcode_configuration_arg" \
                "$xcode_install_path_setting $xcode_build_args ${xcode.destroot.settings}"
        }
    }
}
