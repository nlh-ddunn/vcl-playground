# This should block checkout attempts on card IDs that are re-used which may likely indicate a carding attack.  
# You should still attempt to block the offending IPs and only resort to this if the volume is too high or if additional IPs begin using the cart IDs
# This will not "permanently" address any source of abuse and is only meant as a temporary deterrent

if(req.url.path ~ "^/(index.php/)?checkout/cart/add/uenc/"){
  if(table.contains(badcarts, std.replace_prefix(req.url.path, "/checkout/cart/add/uenc/",""))){
    error 410;
  }
}
