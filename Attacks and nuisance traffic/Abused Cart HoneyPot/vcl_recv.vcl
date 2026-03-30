# This snippet acts as a honeypot for abused carts.
# Instead of a direct rejection, it triggers a synthetic response to trick the automated script into thinking it succeeded.
# You should still attempt to block the offending IPs and only resort to this if the volume is too high or if additional IPs begin using the cart IDs
# This will not "permanently" address any source of abuse and is only meant as a temporary deterrent

if(req.url.path ~ "^/(?:index\.php/)?checkout/cart/add/uenc/([^/]{0,31})(?:/|$)"){
  # Explicit rejection for anything shorter than the standard 32-character Magento cart ID.
  # Using HTTP 405 (Method Not Allowed) indicates to the bot that its request method/format 
  # is completely unsupported for this path, discouraging it from trying different parameters.
  # MDN: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/405
  error 405;
} elseif(req.url.path ~ "^/(?:index\.php/)?checkout/cart/add/uenc/([^/]{32})"){
  if(table.contains(badcarts, re.group.1)){
    # Trigger a custom error code that we will intercept in vcl_error to generate
    # the fake 200 OK honeypot response.
    error 699 "Cart Honeypot";
  }
}
