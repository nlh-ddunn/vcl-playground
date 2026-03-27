if(req.url.path ~ "(index.php)?/(customer/address_file/upload|media/custom_options)+" && req.http.Fastly-Client-IP !~ allowed_ips){
  error 403;
}
