# replace path with known-good image
if(req.url.path == "/favicon.ico"){
  set req.url = "/media/favicon/stores/1/favicon.png";
}
