# Check for the custom tracking header set in vcl_recv denoting a media request.
if (req.http.X-Media-Folder) {
  # If the origin responds with a 404, check its content type.
  # If it is returning an unoptimized/costly HTML response page instead of a simple missing image, trigger our custom error.
  if (beresp.status == 404 && beresp.http.Content-Type ~ "(?i)text/html" && req.url.ext ~ "(?i)^(jpg|jpeg|png|gif|webp|svg|ico|bmp|avif)$") {
    error 605 "Missing Media Image";
  }
}
