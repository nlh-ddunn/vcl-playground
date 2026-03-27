# To proactively serve optimally sized missing icons, we utilize the Fastly Image Optimizer (Fastly IO).
# Official reference: https://developer.fastly.com/reference/io/
#
# Note: You will still need to upload a fallback 'favicon.png' to the appropriate path on your project.
# The current recommendation is /media/favicon/$STORE_NAME/favicon.png
#
# The logic below intercepts standard favicon and app icon requests by leveraging
# native Fastly variables for high performance matching:
# req.url.basename: the exact file name requested (e.g., 'favicon', 'apple-touch-icon', 'mstile-')
# req.url.ext: the original extension requested ('ico', 'png', 'svg')
if(req.url.ext ~ "(?i)^(ico|png|svg)$" && req.url.basename ~ "(?i)^(favicon|apple-touch-icon|android-chrome-|mstile-|safari-pinned-tab)"){
  
  # Preserve the originally requested extension to configure the exact original MIME type in vcl_deliver.
  set req.http.X-Orig-Icon-Ext = req.url.ext;
  
  # Initialize optimal formatting parameters for Fastly IO to the standard 'favicon.ico' catch-all.
  # This defaults all unrecognized endpoints exactly to the rigid 32x32 square dimensions.
  # See: https://developer.fastly.com/reference/io/fit/
  declare local var.io_params STRING;
  set var.io_params = "width=32&height=32&fit=crop"; 
  
  # Match specific icon models to their standard recommended width guidelines natively.
  # Fastly IO automatically maintains the original aspect ratio when only `width=` is passed into it.
  if (req.url.basename ~ "(?i)^apple-touch-icon") {
      set var.io_params = "width=180"; # Validated: standard modern iOS / iPadOS size
  } elsif (req.url.basename ~ "(?i)^mstile-") {
      set var.io_params = "width=144"; # Validated: standard Windows 8/10 tile size
  } elsif (req.url.basename ~ "(?i)^android-chrome-") {
      set var.io_params = "width=192"; # Validated: standard Android Chrome / PWA manifest size
  } elsif (req.url.basename ~ "(?i)^safari-pinned-tab") {
      set var.io_params = "width=32";  # Validated: Safari pinned tabs use SVG, but 32px prevents extreme PNG scaling
  }

  # Fastly IO formally does not support generating '.ico' files natively.
  # To bypass this, we explicitly intercept '.ico' requests and feed '&format=bmp' directly to the engine.
  # We manually override the Fastly IO's default response MIME type internally in vcl_deliver.
  if (req.url.ext == "ico") {
      set var.io_params = var.io_params + "&format=bmp";
  } else {
      set var.io_params = var.io_params + "&format=" + req.url.ext;
  }

  # Rewrite URL dynamically and append Fastly IO query configurations directly to the fallback PNG.
  set req.url = "/media/favicon/" + regsub(req.http.host, "^(www|mcprod)\.", "") + "/favicon.png?" + var.io_params;
}
