# override cache control header for backend based on file extension
# https://www.fastly.com/documentation/reference/vcl/variables/backend-response/beresp-http/
if(req.url.ext ~ "js|css|svg|bmp|jpg|png|jpeg|ico" && beresp.cacheable == false){
  set beresp.cacheable = true;
  set beresp.http.cache-control = "max-age=604800";
}
