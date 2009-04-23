#!/bin/zsh
############################################################## {{{1 ##########
#   $Author: krischik@macports.org $
#   $Revision: 47207 $
#   $Date: 2009-02-23 05:58:00 -0800 (Mon, 23 Feb 2009) $
#   $HeadURL: http://svn.macports.org/repository/macports/trunk/dports/emulators/atari800/files/Atari320XE.app/Contents/MacOS/Atari320XE.command $
############################################################## }}}1 ##########

local User_Data="${HOME}/Library/Application Support/Atari800"
local System_Data="/opt/local/share/atari800";

if test ! -d "${User_Data}"; then
    mkdir "${User_Data}";
fi;

for I in	    \
    "DEMOS1.XFD	    \
    "DEMOS2.XFD	    \
    "DOS25.XFD	    \
    "MYDOS45D.ATR
do
    if test ! -f  "${User_Data}/MYDOS45D.ATR"; then
	cp					\
	    "/opt/local/share/atari800/${I}"	\
	    "${User_Data}/${I}"			;
    fi;
done; unset I

/opt/local/bin/atari800				\
    -320xe					\
    -basic					\
    -pal					\
    -windowed					\
    -width 1280					\
    -height 960					\
    -bpp 16					\
    -xlxe_rom "${System_Data}/ATARIXL.ROM"	\
    -basic_rom "${System_Data}/ATARIBAS.ROM"	\
    ${User_Data}/MYDOS45D.ATR			;

############################################################ {{{1 ###########
# vim: set nowrap tabstop=8 shiftwidth=4 softtabstop=4 noexpandtab :
# vim: set textwidth=0 filetype=zsh foldmethod=marker nospell :
