--- setup.py.orig	Sun Feb 13 17:55:38 2005
+++ setup.py	Sun Feb 13 17:56:40 2005
@@ -879,7 +879,8 @@
         self.extensions.extend(exts)
 
         # Call the method for detecting whether _tkinter can be compiled
-        self.detect_tkinter(inc_dirs, lib_dirs)
+        if ("--disable-tk" not in sysconfig.get_config_var("CONFIG_ARGS")):
+            self.detect_tkinter(inc_dirs, lib_dirs)
 
     def detect_tkinter_darwin(self, inc_dirs, lib_dirs):
         # The _tkinter module, using frameworks. Since frameworks are quite
