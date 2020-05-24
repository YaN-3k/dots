diff --git a/x.c b/x.c
index e5f1737..5cabd60 100644
--- a/x.c
+++ b/x.c
@@ -673,6 +673,7 @@ setsel(char *str, Time t)
 	XSetSelectionOwner(xw.dpy, XA_PRIMARY, xw.win, t);
 	if (XGetSelectionOwner(xw.dpy, XA_PRIMARY) != xw.win)
 		selclear();
+	clipcopy(NULL);
 }
 
 void
