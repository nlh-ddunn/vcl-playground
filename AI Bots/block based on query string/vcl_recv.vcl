#if the bot matches the bot_user_agents table and the query string is not empty
if(table.contains(bot_user_agents, req.http.user-agent) && std.strlen(req.url.qs) > 0){
  error 429; 
}
