# Referencing Documentation for CloudFlare
#
# https://support.cloudflare.com/hc/en-us/articles/206776727-Understanding-the-True-Client-IP-Header
#
# Note: According to CF documentation, the header required for this to work requires an Enterprise license of their service
#
# Note: this should have a sufficiently low enough priority (eg: < 7) so that any Geo-IP rules can still function.

if(req.http.True-Client-IP){
  set client.geo.ip_override = req.http.True-ClientIP;
}

