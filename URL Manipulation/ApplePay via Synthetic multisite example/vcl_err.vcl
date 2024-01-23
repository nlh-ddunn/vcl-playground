if(obj.status == 615 ){
  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.content-type = "text/plain";
  if(req.http.host == "example.com"){
    synthetic "you can add apple pay verification directly to Fastly without uploading files";
  }else if(req.http.host == "example.net"){
    synthetic "even on multiple domains";
  }else{
    synthetic "I got nothing for an undefined location, you may have to add multiple matches for www and non-www or better enforce redirects";
  }
}
