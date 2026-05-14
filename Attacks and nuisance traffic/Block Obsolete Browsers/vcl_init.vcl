# Note: its best to create these tables manually from within the Magento admin panel.
# this is only present to use as a reference.

# this table contains urls that should be protected
table protected_urls {
  "/": ""
}

# this table was last updated on 2026-05-13
# Top 10 browsers determined based on global market share statistics (e.g. StatCounter, BrowserStack)
# Criteria for minimum versions: most recent 5 releases or within 1 year, whichever is most recent.
table allowed_browsers {
  "Safari": "22",
  "Chrome": "143",
  "Microsoft Edge": "143",
  "Firefox": "145",
  "Opera": "126",
  "SamsungBrowser": "28",
  "UCBrowser": "16",
  "Yandex": "24",
  "Android": "143",
  "Coc Coc": "143"
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