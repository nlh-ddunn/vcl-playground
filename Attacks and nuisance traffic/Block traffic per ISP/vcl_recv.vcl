# blocks traffic per the ISP name
# these can be found on sites like bgpview.io

# https://developer.fastly.com/reference/vcl/variables/client-connection/client-as-name/

if(std.tolower(client.as.name) ~ "ISP Name"){
  error 403;
}
