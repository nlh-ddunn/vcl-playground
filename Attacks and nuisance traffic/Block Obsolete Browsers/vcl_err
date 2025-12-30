# Feel free to replace the latin text with your own, including a custom error page if desired
# Note: this may break logging, so alternatively swicthing the obj.status from 200 to another 2XX response (eg: 204) may allow you to better filter results

if(obj.status == 643){
  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "text/plain";
  synthetic {"
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  "};
  
}
