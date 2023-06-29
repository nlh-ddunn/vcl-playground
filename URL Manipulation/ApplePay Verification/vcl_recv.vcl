# Based on ideal workflow posited in https://experienceleague.adobe.com/docs/commerce-cloud-service/user-guide/configure-store/robots-sitemap.html

if(req.url.path ~ "^/.well-known/apple-developer-merchantid-domain-association.txt$"){
  set req.url = "/media/apple-developer-merchantid-domain-association.txt";
}
