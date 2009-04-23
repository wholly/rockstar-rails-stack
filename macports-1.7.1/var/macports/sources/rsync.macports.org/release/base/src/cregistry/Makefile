# $Id: Makefile 32209 2007-12-20 08:27:05Z jmpp@macports.org $

OBJS = registry.o entry.o sql.o
STLIB_NAME = cregistry.a
RANLIB = ranlib


include ../../Mk/macports.autoconf.mk


all:: ${STLIB_NAME}

.c.o:
	${CC} -c -DUSE_TCL_STUBS ${CFLAGS} ${TCL_DEFS} ${SHLIB_CFLAGS} $< -o $@

${STLIB_NAME}:: ${OBJS}
	${STLIB_LD} ${STLIB_NAME} ${OBJS}
	${RANLIB} ${STLIB_NAME}

clean::
	rm -f ${STLIB_NAME} ${OBJS}

distclean:: clean

test:

install:: ${STLIB_NAME}
