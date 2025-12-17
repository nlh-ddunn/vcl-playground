# this is not advisable unless other protections or restrictions are put in place to avoid API abuse
if((beresp.status == 401 || beresp.status == 404) && req.restarts < 1 && req.url.path ~ "/rest/V1/.*/"){
  log "received " + beresp.status + " retrying";
  restart;
}
