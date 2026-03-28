# Provides a GeoIP override utilizing the `True-Client-IP` header.
#
# This header is utilized by both Akamai and Cloudflare (among other providers) 
# to pass the original client IP to the origin.
#
# Cloudflare Documentation:
# https://support.cloudflare.com/hc/en-us/articles/206776727-Understanding-the-True-Client-IP-Header
# Note: According to CF documentation, the header required for this to work requires an Enterprise license.
#
# Akamai Documentation:
# https://techdocs.akamai.com/property-mgr/docs/origin-server#true-client-ip-header
#
# Note: this should have a sufficiently low priority (eg: < 7) so that any Geo-IP rules can still function.

if(req.http.True-Client-IP){
  set client.geo.ip_override = req.http.True-Client-IP;
}
