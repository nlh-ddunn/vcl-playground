#restricted manual override of cors headers
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Headers
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Methods


if(req.url.path ~ "^/api/[a-z0-9]{8}-([a-z0-9]{4}-){3}[a-z0-9]{12}/graphql" && table.contains(cors_allowed, std.replace(req.http.referer, "https://", ""))){
  set resp.http.access-control-allow-origin = "*";
  set resp.http.access-control-allow-headers = "content-type, x-requested-with, store";
  set resp.http.access-control-allow-methods = "GET,HEAD,PUT,PATCH,POST,DELETE,OPTIONS";
}
