if(table.contains(allowed_browsers, client.browser.name) && (req.method == "POST" || table.lookup(protected_urls, req.url.path))){
  declare local var.curver INTEGER;
  declare local var.minver INTEGER;
  set var.curver = std.atoi(client.browser.version);
  set var.minver = std.atoi(table.lookup(allowed_browsers,client.browser.name));

  if(var.curver < var.minver){
    if(table.contains(carve_out_browsers,client.browser.name) && var.curver != std.atoi(table.lookup(carve_out_browsers,client.browser.name))){
      error 643;
    }
  }
}

