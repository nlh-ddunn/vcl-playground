# Note: its best to create these tables manually from within the Magento admin panel.
# this is only present to use as a reference.

# this table contains urls that should be protected
table protected_urls {
  "/": ""
}

# this table was last updated on 2026-02-24
# Top 10 browsers determined based on global market share statistics (e.g. StatCounter, BrowserStack)
# Criteria for minimum versions: most recent 6 months or 5 releases, whichever is newer.
table allowed_browsers {
  "Safari": "26",
  "Chrome": "141",
  "Microsoft Edge": "141",
  "Firefox": "143",
  "Opera": "123",
  "SamsungBrowser": "29",
  "UCBrowser": "15",
  "Yandex": "25",
  "Android": "141",
  "Coc Coc": "145"
}
table carve_out_browsers {
  "Chrome": "79" #Some legitimate site monitors spoof this old version of Chrome
}