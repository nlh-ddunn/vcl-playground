# Note: its best to create these tables manually from within the Magento admin panel.
# this is only present to use as a reference.

# this table contains urls that should be protected
table protected_urls {
  "/": ""
}

# this table was last updated on 2026-06-23
# Top 10 browsers determined based on global market share statistics (e.g. StatCounter, BrowserStack)
# Criteria for minimum versions: most recent 5 releases or within 1 year, whichever is most recent.
table allowed_browsers {
  "Safari": "26",
  "Chrome": "146",
  "Microsoft Edge": "146",
  "Firefox": "148",
  "Opera": "128",
  "SamsungBrowser": "29",
  "UCBrowser": "17",
  "Yandex": "25",
  "Android": "146",
  "Coc Coc": "146"
}
table carve_out_browsers {
  "Chrome": "79" #Some legitimate site monitors spoof this old version of Chrome
}

# this table contains legacy/unsupported browsers often found spoofed in malicious traffic, use at your own risk
table disallowed_browsers {
  "MSIE": "",
  "Internet Explorer": "",
  "Netscape": "",
  "Camino": "",
  "Galeon": "",
  "Flock": "",
  "RockMelt": ""
}