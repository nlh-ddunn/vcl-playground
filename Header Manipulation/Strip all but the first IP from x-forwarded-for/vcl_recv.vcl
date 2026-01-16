# This logic was updated to allow IPv6 usage, which was not previously present as IPv6 was not used on Adobe Commerce Cloud.
# Note that caution should still be taken as this header can be spoofed easily and should still not be substituted for logging on the outer-most networking layers as the source of truth for traffic.
if(req.http.x-forwarded-for ~ ","){
  declare local var.strippedxff STRING;
  set var.strippedxff = regsub(req.http.x-forwarded-for, "^([^,]+),.*$", "\1");
  log "Stripping " + req.http.x-forwarded-for + " to " + var.strippedxff;
  set req.http.x-forwarded-for = var.strippedxff;
  restart;
}
