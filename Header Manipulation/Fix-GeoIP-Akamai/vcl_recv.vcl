# Referencing Documentation for Akamai
#
# https://techdocs.akamai.com/property-mgr/docs/origin-server#true-client-ip-header
#
# Note: Akamai passes the original client IP in the True-Client-IP header. 
#
# Note: this should have a sufficiently low enough priority (eg: < 7) so that any Geo-IP rules can still function.

if(req.http.True-Client-IP){
  set client.geo.ip_override = req.http.True-Client-IP;
}
