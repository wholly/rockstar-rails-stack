--- fetch.c.orig	2006-01-13 10:07:49.000000000 +0100
+++ fetch.c	2007-09-08 23:13:26.000000000 +0200
@@ -202,12 +202,16 @@
 
 	fprintf(stderr, "\r%-46.46s", xs->name);
 	if (xs->size <= 0) {
+#ifdef __FreeBSD__
 		setproctitle("%s [%s]", xs->name, stat_bytes(xs->rcvd));
+#endif
 		fprintf(stderr, "        %s", stat_bytes(xs->rcvd));
 	} else {
+#ifdef __FreeBSD__
 		setproctitle("%s [%d%% of %s]", xs->name,
 		    (int)((100.0 * xs->rcvd) / xs->size),
 		    stat_bytes(xs->size));
+#endif
 		fprintf(stderr, "%3d%% of %s",
 		    (int)((100.0 * xs->rcvd) / xs->size),
 		    stat_bytes(xs->size));
