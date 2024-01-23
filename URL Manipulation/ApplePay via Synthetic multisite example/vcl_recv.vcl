if(req.url.path ~ "^/.well-known/apple-developer-merchantid-domain-association.txt$"){
  error 615;
}
