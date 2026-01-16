if(req.url.path ~ "^/api/[a-z0-9]{8}-([a-z0-9]{4}-){3}[a-z0-9]{12}/graphql"){
  return(pass);
}
