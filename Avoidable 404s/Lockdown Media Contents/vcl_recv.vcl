# Intercepts requests pointing to the media folder to lockdown parameters.
if (req.url.path ~ "^/(index\.php/)?media/") {
  # Strip all query arguments not utilized by Fastly Image Optimizer (Fastly IO).
  # See: https://developer.fastly.com/reference/io/
  set req.url = querystring.sort(querystring.regfilter_except(req.url, "(?i)^(width|height|fit|format|auto|bg-color|canvas|crop|dpr|pad|trim|orient|precrop|quality|blur|sharpen|brightness|contrast|saturation|resize-filter|upscale|profile)$"), true);
  
  # Set a marker header so downstream VCL states (like vcl_fetch) know this is a media folder request
  set req.http.X-Media-Folder = "1";
}
