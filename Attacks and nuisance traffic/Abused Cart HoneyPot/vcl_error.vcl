# Intercept the custom error code triggered by our honeypot logic in vcl_recv
# and convert it into a fake 200 OK success response.

if (obj.status == 699 && obj.response == "Cart Honeypot") {
  # Modify the HTTP status to appear successful to the attacker's script
  set obj.status = 200;
  set obj.response = "OK";
  set obj.http.Content-Type = "application/json";
  
  # Return a synthetic payload imitating a successful JSON response
  # but including the PG-13 honeypot message.
  synthetic {"{
    "success": true,
    "message": "Cart updated.",
    "debug_note": "Just kidding, you complete jackass. Your script is blocked. Find a better hobby than carding."
  }"};
  
  return (deliver);
}
