# $Id: macports.tea.mk 30816 2007-11-07 19:52:25Z jmpp@macports.org $

.SUFFIXES: .m

.m.o:
	${CC} -c -DUSE_TCL_STUBS ${OBJCFLAGS} ${TCL_DEFS} ${SHLIB_CFLAGS} $< -o $@

.c.o:
	${CC} -c -DUSE_TCL_STUBS ${CFLAGS} ${TCL_DEFS} ${SHLIB_CFLAGS} $< -o $@

$(SHLIB_NAME):: ${OBJS}
	${SHLIB_LD} ${OBJS} -o ${SHLIB_NAME} ${TCL_STUB_LIB_SPEC} ${SHLIB_LDFLAGS} ${LIBS}

all:: ${SHLIB_NAME}

clean::
	rm -f ${OBJS} ${SHLIB_NAME} so_locations

distclean:: clean

install:: all
	$(INSTALL) -d -o ${DSTUSR} -g ${DSTGRP} -m ${DSTMODE} ${INSTALLDIR}
	$(INSTALL) -o ${DSTUSR} -g ${DSTGRP} -m 444 ${SHLIB_NAME} ${INSTALLDIR}
	$(SILENT) $(TCLSH) ../pkg_mkindex.tcl ${INSTALLDIR}
