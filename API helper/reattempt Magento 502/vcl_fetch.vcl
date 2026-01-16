if(beresp.status == 502 && req.restarts < 1){
  log "received " + beresp.status + " retrying";
  restart;
}
