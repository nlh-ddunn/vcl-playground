# note: you will still need to upload a favicon.png to the appropriate path on your project
# the current recommendation is /media/favicon/$STORE_NAME/favicon.png
# apple devices will generally prefer 100x100 px png files
if(req.url.path == "/favicon.ico || req.url.path == "/apple-touch-icon.png"){
  set req.url = "/media/favicon/" + regsub(req.http.host, "^www\.", "") + "/favicon.png";
}
