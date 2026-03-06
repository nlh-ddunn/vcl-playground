# You should ideally add this with a high enough priority (eg: < 10) so no other actions need to be processed

if (req.url.path ~ "(?i)^/(core/|misc/|modules/|profiles/|scripts/|themes/|update\.php|install\.php|user/login|user/register|node/add)") {
 error 403; #set as HTTP 403 as this server should not be handling Drupal requests
}
