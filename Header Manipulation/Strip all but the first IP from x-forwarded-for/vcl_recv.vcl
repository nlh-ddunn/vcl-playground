if(std.strlen(req.http.x-forwarded-for) > 15){
  declare local var.strippedxff STRING;
  set var.strippedxff = regsuball(req.http.x-forwarded-for, ",( )*([0-9]{1,3}\.){3}[0-9]{1,3}", "");
  log "Stripping " + req.http.x-forwarded-for + " to " + var.strippedxff;
  set req.http.x-forwarded-for = var.strippedxff;
  restart;
}
