if(obj.status == 615 ){
  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.content-type = "text/plain";
  #Place contents of verification file(s) in the synthetic responses
  if(table.contains(apple_pay_domains, regsub(req.http.host, "^(?i)www\.", ""))){
    synthetic table.lookup(apple_pay_domains, regsub(req.http.host, "^(?i)www\.", ""));
  }else{
    synthetic "I got nothing for an undefined location, you may have to add multiple matches for www and non-www or better enforce redirects";
  }
}
