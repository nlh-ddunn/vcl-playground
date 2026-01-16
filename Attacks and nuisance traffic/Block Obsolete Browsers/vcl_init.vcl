# Note: its best to create these tables manually from within the Magento admin panel.
# this is only present to use as a reference.

# this table contains urls that should be protected
table protected_urls{
  "/": "",
}

# this table was last updated on 2026-01-07
table allowed_browsers{
  "Safari": "19",
  "Chrome": "141",
  "Microsoft Edge": "141",
  "Firefox": "143",
  "Opera": "122",
  "SamsungBrowser": "28",
}
table carve_out_browsers{
  "Chrome": "79", #Some legitimate site monitors spoof this old version of Chrome
}