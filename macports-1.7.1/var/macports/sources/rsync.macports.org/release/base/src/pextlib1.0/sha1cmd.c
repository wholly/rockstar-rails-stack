/*
 * sha1cmd.c
 * $Id: sha1cmd.c 19376 2006-09-02 03:19:06Z yeled@macports.org $
 * Copied from md5cmd.c 20040903 EH
 *
 * Copyright (c) 2002 - 2003 Apple Computer, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of Apple Computer, Inc. nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#if HAVE_CONFIG_H
#include <config.h>
#endif

#include <tcl.h>

#if HAVE_STRING_H
#include <string.h>
#endif

#if defined(HAVE_LIBCRYPTO) && !defined(HAVE_LIBMD)

/* Minimal wrapper around OpenSSL's libcrypto, as a compatibility
 * layer for FreeBSD's libmd library.
 * Originally written by: Rob Braun (bbraun) 1/18/2002
 */

#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

#include <openssl/sha.h>

#define SHA1Init(x) SHA1_Init(x)
#define SHA1Update(x,y,z) SHA1_Update(x,y,z)
#define SHA1Final(x,y) SHA1_Final(x,y)

#include "md_wrappers.h"
CHECKSUMEnd(SHA1, SHA_CTX, SHA_DIGEST_LENGTH)
CHECKSUMFile(SHA1, SHA_CTX)
CHECKSUMData(SHA1, SHA_CTX)

#elif defined(HAVE_LIBMD)
#include <sys/types.h>
#include <sha.h>
#define SHA1File(x, y) SHA1_File(x, y)
#else
#error libcrypto or libmd are required
#endif

int SHA1Cmd(ClientData clientData UNUSED, Tcl_Interp *interp, int objc, Tcl_Obj *CONST objv[])
{
	char *file, *action;
	char buf[2*SHA_DIGEST_LENGTH + 1];
	const char usage_message[] = "Usage: sha1 file ?file?";
	const char error_message[] = "Could not open file: ";
	Tcl_Obj *tcl_result;

	if (objc != 3) {
		Tcl_WrongNumArgs(interp, 1, objv, "action ?file?");
		return TCL_ERROR;
	}

	/*
	 * Only the 'file' action is currently supported
	 */
	action = Tcl_GetString(objv[1]);
	if (strcmp(action, "file") != 0) {
		tcl_result = Tcl_NewStringObj(usage_message, sizeof(usage_message) - 1);
		Tcl_SetObjResult(interp, tcl_result);
		return TCL_ERROR;
	}
	file = Tcl_GetString(objv[2]);

	if (!SHA1File(file, buf)) {
		tcl_result = Tcl_NewStringObj(error_message, sizeof(error_message) - 1);
		Tcl_AppendObjToObj(tcl_result, Tcl_NewStringObj(file, -1));
		Tcl_SetObjResult(interp, tcl_result);
		return TCL_ERROR;
	}
	tcl_result = Tcl_NewStringObj(buf, sizeof(buf) - 1);
	Tcl_SetObjResult(interp, tcl_result);
	return TCL_OK;
}
