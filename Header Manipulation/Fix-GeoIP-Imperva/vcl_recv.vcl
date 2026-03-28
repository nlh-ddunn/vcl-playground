# Referencing Documentation for Imperva / Incapsula
#
# https://docs-cybersec.thalesgroup.com/bundle/cloud-application-security/page/onboarding/setup-checklist.htm
#
# Note: Imperva passes the original client IP in the Incap-Client-IP header. 
#
# Note: this should have a sufficiently low enough priority (eg: < 7) so that any Geo-IP rules can still function.

if(req.http.Incap-Client-IP){
  set client.geo.ip_override = req.http.Incap-Client-IP;
}
