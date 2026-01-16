# Note: its best to create these tables manually from within the Magento admin panel.
# this is only present to use as a reference.

# this table contains urls that should be protected
table protected_urls {
  "/": ""
}

# this table was last updated on 2026-01-16
# Top 10 browsers determined based on global market share statistics (e.g. StatCounter, BrowserStack)
table allowed_browsers {
  "Safari": "18",
  "Chrome": "139",
  "Microsoft Edge": "139",
  "Firefox": "142",
  "Opera": "121",
  "SamsungBrowser": "28",
  "UCBrowser": "14",
  "Yandex": "25",
  "Android": "130",
  "Coc Coc": "130"
}
table carve_out_browsers {
  "Chrome": "79" #Some legitimate site monitors spoof this old version of Chrome
}