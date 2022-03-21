if(obj.status == 602 && obj.response == "addslash"){
  set obj.status = 301;
  set obj.response = "Moved Permanently";
  set obj.http.Location = "https://" + req.http.host + req.url.path + "/" + if (std.strlen(req.url.qs) > 0, "?" req.url.qs, "");
  return(deliver); 
}
