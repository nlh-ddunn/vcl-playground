# Filters common marketing and tracking query parameters from the URL to improve cache hit rates.
# Removed parameters include:
# - Google Analytics: utm_*
# - Google Ads: gclid, gclsrc
# - DoubleClick: dclid
# - Facebook: fbclid
# - Instagram: igshid
# - Mailchimp: mc_cid, mc_eid
# - Marketo: mkt_tok
# - HubSpot: _hsenc, _hsmi
# - TikTok: ttclid
# - Microsoft Advertising (Bing): msclkid
# - Twitter: twclid
# - LinkedIn: li_fat_id
# - Yandex: yclid

if (req.url.qs ~ "(?i)(utm_|gclid|gclsrc|dclid|fbclid|igshid|mc_cid|mc_eid|mkt_tok|_hsenc|_hsmi|ttclid|msclkid|twclid|li_fat_id|yclid)=") {
  # filter query strings based on regular expression
  # https://developer.fastly.com/reference/vcl/functions/query-string/querystring-regfilter/
  # normalizing query strings to ensure cache hits
  # https://developer.fastly.com/reference/vcl/functions/query-string/querystring-sort/
  set req.url = querystring.sort(querystring.regfilter(req.url, "(?i)^(utm_.*|gclid|gclsrc|dclid|fbclid|igshid|mc_cid|mc_eid|mkt_tok|_hsenc|_hsmi|ttclid|msclkid|twclid|li_fat_id|yclid)$"), true);
  restart;
}
