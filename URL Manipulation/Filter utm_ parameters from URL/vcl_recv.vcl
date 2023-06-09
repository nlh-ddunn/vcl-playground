if(req.url.qs ~ "utm_"){
  # filter query strings based on regular expression
  # https://developer.fastly.com/reference/vcl/functions/query-string/querystring-regfilter/
  set req.url = querystring.regfilter(req.url, "utm_.*");
  log req.url;
  restart;
}
