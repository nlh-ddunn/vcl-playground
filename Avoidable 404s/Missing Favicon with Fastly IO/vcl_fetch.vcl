# Ensure that the origin's fallback 'favicon.png' file has a valid set of expiry headers.
# If the origin response lacks proper cache-control headers, we force a minimum of 7 days (604800 seconds).
# We can identify these intercepted requests by checking for the custom X-Orig-Icon-Ext header we set in vcl_recv.
if (req.http.X-Orig-Icon-Ext) {
  # If the origin returns a 404 even for the fallback favicon, 
  # trigger a custom error block to serve a synthetic empty response.
  if (beresp.status == 404) {
    error 604 "Missing Favicon";
  }

  if (beresp.ttl < 604800s) {
    set beresp.ttl = 604800s;
    set beresp.http.Cache-Control = "max-age=604800, public";
  }
}
