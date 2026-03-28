# Attack Paths Blocked:
# - Session Reaper (CVE-2025-54236 / CVE-2022-24086): /customer/address_file/upload
# - Polyshell (APSB25-94): /media/custom_options or /pub/media/custom_options
if(req.url.path ~ "(index.php)?/((pub/)?media/custom_options|customer/address_file/upload)" && req.http.Fastly-Client-IP !~ allowed_ips){
  error 403;
}
