# run on fetch so this is only triggered on uncached requests
# check if user-agent matches listed bots
if(table.contains(bot_user_agents, req.http.user-agent)){
  error 429;
}
