# You should ideally add this with a high enough priority (eg: < 10) so no other actions need to be processed

if(req.url.path ~ "(A|a)utodiscover.xml$){
 error 405; #set as HTTP 405 as this server should not be handling exchange client autodiscover requets
}
