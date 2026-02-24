# You should ideally add this with a high enough priority (eg: < 10) so no other actions need to be processed

if (req.url.path ~ "(?i)^/(wp-admin|wp-content|wp-includes|wp-json|wp-login\.php|xmlrpc\.php)") {
 error 403; #set as HTTP 403 as this server should not be handling WordPress requests
}
