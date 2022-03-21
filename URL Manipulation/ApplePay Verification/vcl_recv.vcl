# Based on ideal workflow posited in https://devdocs.magento.com/cloud/trouble/robots-sitemap.html#use-a-fastly-vcl-snippet-for-redirect


if(req.url.path ~ "^/.well-known/apple-developer-merchantid-domain-association.txt$"){
  set req.url = "/media/apple-developer-merchantid-domain-association.txt";
}
