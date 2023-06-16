#replace enforced content-security-policy header with the report-only equivalent
if(beresp.http.content-security-policy){
  set beresp.http.content-security-policy-report-only = beresp.http.content-security-policy;
  unset beresp.http.content-security-policy;
}
