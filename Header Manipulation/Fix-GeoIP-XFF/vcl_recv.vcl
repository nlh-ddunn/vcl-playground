# This snippet overrides the Fastly GeoIP lookup key with the first IP in the X-Forwarded-For header.
# This is useful when behind a proxy 
# Caution: X-Forwarded-For can be spoofed. Ensure you trust the upstream proxy.

if(req.http.x-forwarded-for ~ ","){
  set client.geo.ip_override = regsub(req.http.x-forwarded-for, "^([^,]+),.*$", "\1");
} else {
  set client.geo.ip_override = req.http.x-forwarded-for;
}
