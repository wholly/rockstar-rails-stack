# $Id: x11font-1.0.tcl 47099 2009-02-22 03:08:09Z blb@macports.org $
#
# Copyright (c) 2009 The MacPorts Project
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
# 3. Neither the name of The MacPorts Project nor the names of its
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
#
# Usage:
# PortGroup       x11font 1.0
# x11font.setup   portname version fontsubdir
# where portname is just the name for the port (and should match the
# distname for simplicity), version is the port's version, and the fontsubdir
# is the subdirectory of ${prefix}/share/fonts used by this font.
# This automatically defines name, version, categories, homepage,
# master_sites, and depends_build as appropriate, and sets up
# configure.args, post-destroot, and post-activate. It can do
# post-deactivate if that ever becomes an option in MacPorts.
#

proc x11font.setup {myportname myportversion myfontsubdir} {
    global homepage prefix name extract.suffix master_sites x11font_myfontdir

    name             ${myportname}
    version          ${myportversion}
    categories       x11 x11-font graphics
    homepage         http://www.x.org/
    master_sites     ${homepage}pub/individual/font/
    use_bzip2        yes
    depends_build    port:pkgconfig bin:bdftopcf:bdftopcf \
                     port:xorg-font-util port:mkfontscale port:mkfontdir \
                     bin:gzip:gzip
    set x11font_myfontdir    ${prefix}/share/fonts/${myfontsubdir}
    configure.args   --with-fontdir=${x11font_myfontdir}

    post-destroot {
        foreach fontsFile {fonts.alias fonts.dir fonts.list fonts.scale fonts.cache-1} {
            if {[file exists ${destroot}${x11font_myfontdir}/${fontsFile}]} {
                delete ${destroot}${x11font_myfontdir}/${fontsFile}
            }
        }
    }

    post-activate {
        system "mkfontscale ${x11font_myfontdir}"
        system "mkfontdir ${x11font_myfontdir}"
    }

    # This should be done when uninstalling, but deactivate doesn't currently
    # work
#    post-deactivate {
#        system "mkfontscale ${x11font_myfontdir}"
#        system "mkfontdir ${x11font_myfontdir}"
#    }

    livecheck.check     regex
    livecheck.regex     ${name}-(\[\\d.\]+)${extract.suffix}
    livecheck.url       ${master_sites}
}

