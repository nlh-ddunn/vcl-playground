if(req.url.path ~ "(index.php)?/customer/address_file/upload" && req.http.Fastly-Client-IP !~ allowed_ips){
  error 403;
}
