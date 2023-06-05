# spoof the via header (for people who do not like "via Varnish" in responses)
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Via
set resp.http.via = "Chocolate Cake 2.4.6";
