if(req.url.path ~ "^/checkout/cart/add/uenc/"){
  if(table.contains(badcarts, std.replace_prefix(req.url.path, "/checkout/cart/add/uenc/",""))){
    error 410;
  }
}
