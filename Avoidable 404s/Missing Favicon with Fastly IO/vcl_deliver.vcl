# Ensure the Content-Type matches what the browser originally requested for the icon.
# Because vcl_recv dynamically utilizes Fastly IO to optimize images (which forces output to PNG/BMP/etc.),
# the original MIME type might be altered. We override the response Content-Type here based on the
# original requested extension stored in req.http.X-Orig-Icon-Ext.
if (req.http.X-Orig-Icon-Ext) {
  if (req.http.X-Orig-Icon-Ext == "ico") {
    # Modern browsers perfectly accept PNG/BMP encoded image data served as image/x-icon.
    set resp.http.Content-Type = "image/x-icon";
  } elsif (req.http.X-Orig-Icon-Ext == "svg") {
    set resp.http.Content-Type = "image/svg+xml";
  } elsif (req.http.X-Orig-Icon-Ext == "png") {
    # Fastly IO will natively output image/png due to '&format=png', but forcefully 
    # setting it here ensures strict compatibility with iOS requesting 'apple-touch-icon.png'.
    set resp.http.Content-Type = "image/png";
  }

  # Clean up the temporary tracking header so it's not forwarded to the client unnecessarily.
  unset req.http.X-Orig-Icon-Ext;
}
