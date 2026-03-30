# Provides a combined GeoIP override prioritizing proprietary headers over X-Forwarded-For.
#
# Akamai / Cloudflare:
# https://techdocs.akamai.com/property-mgr/docs/origin-server#true-client-ip-header
# https://support.cloudflare.com/hc/en-us/articles/206776727-Understanding-the-True-Client-IP-Header
# (Note: CF requires an Enterprise license for this header)
#
# Imperva / Incapsula:
# https://docs-cybersec.thalesgroup.com/bundle/cloud-application-security/page/onboarding/setup-checklist.htm
#
# Fallback: First IP in X-Forwarded-For. Fastly GeoIP lookup key is overridden.
# Caution: X-Forwarded-For can be spoofed. Ensure you trust the upstream proxy.
#
# Note: this should have a sufficiently low priority (eg: < 7) so that any Geo-IP rules can still function.

if(req.http.True-Client-IP){
  set client.geo.ip_override = req.http.True-Client-IP;
} elsif(req.http.Incap-Client-IP){
  set client.geo.ip_override = req.http.Incap-Client-IP;
} elsif(req.http.x-forwarded-for){
  if(req.http.x-forwarded-for ~ ","){
    set client.geo.ip_override = regsub(req.http.x-forwarded-for, "^([^,]+),.*$", "\1");
  } else {
    set client.geo.ip_override = req.http.x-forwarded-for;
  }
}
