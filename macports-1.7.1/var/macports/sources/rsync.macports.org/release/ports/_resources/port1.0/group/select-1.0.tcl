# et:ts=4
# select-1.0.tcl
#
# $Id: select-1.0.tcl 48968 2009-04-01 03:47:35Z raimue@macports.org $
#
# Copyright (c) 2009 The MacPorts Project
# Copyright (c) 2009 Rainer Mueller <raimue@macports.org>
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

options select.group select.file

default select.group ""
default select.file ""

post-destroot {
    if {${select.file} != "" || ${select.group} != ""} {
        xinstall -m 755 -d ${destroot}${prefix}/etc/select/${select.group}
        xinstall -m 644 ${select.file} ${destroot}${prefix}/etc/select/${select.group}

        reinplace s|\${prefix}|${prefix}|g ${destroot}${prefix}/etc/select/${select.group}/[file tail ${select.file}]
        reinplace s|\${frameworks_dir}|${frameworks_dir}|g ${destroot}${prefix}/etc/select/${select.group}/[file tail ${select.file}]
        reinplace s|\${applications_dir}|${applications_dir}|g ${destroot}${prefix}/etc/select/${select.group}/[file tail ${select.file}]
    } else {
        ui_debug "PortGroup select: select.group and select.file not set"
    }
}
