# $Id: Makefile 31519 2007-11-27 04:10:57Z jmpp@macports.org $

SCRIPTS=	PortIndex2MySQL

edit = sed \
	-e 's,@TCL_PACKAGE_DIR@,$(TCL_PACKAGE_DIR),g'


include ../../Mk/macports.autoconf.mk


all: ${SCRIPTS}

PortIndex2MySQL: PortIndex2MySQL.tcl
	${edit} $< > $@
	chmod 755 $@

clean:
	rm -f ${SCRIPTS}

distclean: clean
