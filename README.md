# vcl-playground
This is a collection of VCL snippets for addressing commonly encountered issues on Magento / Adobe Commerce with Fastly kept in a repository for quick and easy use and reuse.

Files are added when and if I find an issue requiring re-use (instead of one-offs) of VCL code.  They are not intended to be used together since there is no attempt to ensure there are no crossover / re-use of error codes and updates / changes may be expected if implemented on a live site.

Note: some snippets act in ways to treat symptoms of issues and may cause entirely different ones (such as API re-attempts) which may allow the front-end to appear more responsive and less error prone at the expense of additional load on the backend and degraded stability and performance.  Please do not implement snippets on a live site without proper testing and understanding of the potential impact.

# VCL Snippets Listing

This document provides a brief listing and description of the VCL snippets present in the `vcl-playground` repository.

## AI Bots

*   **Block Based on Cache State**
    *   **Description**: Identifies and blocks bots based on their user-agents when requesting uncached resources to minimize load on the backend without blocking all requests in their entirety.
    *   **Files**: `AI Bots/block based on cache state/` (`vcl_init.vcl`, `vcl_fetch.vcl`)

*   **Block Based on Query String**
    *   **Description**: Blocks requests containing specific query string parameters that are associated with unwanted bot traffic.
    *   **Files**: `AI Bots/block based on query string/` (`vcl_init.vcl`, `vcl_recv.vcl`)

## Attacks and Nuisance Traffic

*   **Ban Abused Carts**
    *   **Description**: Blocks requests to specific shopping cart IDs that are being abused, typically defined in a VCL table.
    *   **Files**: `Attacks and nuisance traffic/Ban Abused Carts from Adobe Commerce or Magento/` (`vcl_init.vcl`, `vcl_recv.vcl`)

*   **Block Exchange Server Requests**
    *   **Description**: Blocks requests targeting Microsoft Exchange Server paths (e.g., `autodiscover`, `owa`), which are often used by scanners to find vulnerabilities and may also generate unneeded backend load.
    *   **Files**: `Attacks and nuisance traffic/Block Exchange Server Requests/vcl_recv.vcl`

*   **Block Traffic per ISP**
    *   **Description**: Blocks traffic from specific ISPs based on the `client.as.name` variable, utilizing GeoIP data.
    *   **Files**: `Attacks and nuisance traffic/Block traffic per ISP/vcl_recv.vcl`

*   **Block Obsolete Browsers**
    *   **Description**: Blocks requests from browser versions considered obsolete or insecure.
    *   **Files**: `Attacks and nuisance traffic/Block Obsolete Browsers/` (`vcl_init`, `vcl_recv`, `vcl_err`)

## Avoidable 404s

*   **Define Missing Favicon/Apple Icon**
    *   **Description**: Rewrites requests for `favicon.ico` or `apple-touch-icon.png` to a specific path (e.g., `/media/favicon/...`), reducing 404 errors for these common assets.
    *   **Files**: `Avoidable 404s/Define missing favicon.ico and apple/vcl_recv.vcl`

## CloudFlare

*   **Fix-GeoIP**
    *   **Description**: Overrides the Fastly GeoIP lookup key with the `True-Client-IP` header provided by CloudFlare, ensuring accurate geolocation for requests coming through CloudFlare.
    *   **Files**: `CloudFlare/Fix-GeoIP/vcl_recv.vcl`

## Header Manipulation

*   **Force Content-Security-Policy to Report-Only**
    *   **Description**: Downgrades an enforced `Content-Security-Policy` header to `Content-Security-Policy-Report-Only`, useful for testing CSP changes without breaking functionality.
    *   **Files**: `Header Manipulation/Force Content-Security-Policy to report-only/vcl_fetch.vcl`

*   **Force Caching on Backends**
    *   **Description**: Sets caching headers for backend responses that do not send proper expiry information, enforcing a default TTL.
    *   **Files**: `Header Manipulation/Force caching on backends that do not send proper expiry/vcl_fetch.vcl`

*   **Override CORS for Commerce Cloud**
    *   **Description**: Modifies CORS headers (e.g., `Access-Control-Allow-Origin`) to support Adobe Commerce Cloud requirements.
    *   **Files**: `Header Manipulation/Override CORS for Commerce Cloud/` (`vcl_deliver.vcl`, `vcl_init.vcl`)

*   **Spoof the Via Header**
    *   **Description**: Modifies the `Via` header, possibly to hide upstream proxies or for internal routing purposes.
    *   **Files**: `Header Manipulation/Spoof the via header/vcl_deliver.vcl`

*   **Strip All But First IP from X-Forwarded-For**
    *   **Description**: Cleans the `X-Forwarded-For` header by keeping only the first IP address, ensuring the origin sees the true client IP.
    *   **Files**: `Header Manipulation/Strip all but the first IP from x-forwarded-for/vcl_recv.vcl`

## URL Manipulation

*   **Add Trailing Slash**
    *   **Description**: Redirects or rewrites URLs to ensure they end with a trailing slash, standardizing URL structure.
    *   **Files**: `URL Manipulation/Add Trailing Slash/` (`vcl_recv.vcl`, `vcl_error.vcl`)

*   **ApplePay Verification**
    *   **Description**: Handles requests for ApplePay verification files.
    *   **Files**: `URL Manipulation/ApplePay Verification/vcl_recv.vcl`

*   **ApplePay via Synthetic Multisite**
    *   **Description**: A more complex setup for handling ApplePay verification in a multisite environment using synthetic responses.
    *   **Files**: `URL Manipulation/ApplePay via Synthetic multisite example/` (`vcl_recv.vcl`, `vcl_err.vcl`)

*   **Filter utm_ parameters**
    *   **Description**: Strips Google Analytics (`utm_`) parameters from the query string to improve cache hit rates.
    *   **Files**: `URL Manipulation/Filter utm_ parameters from URL/vcl_recv.vcl`

## API Helper

*   **Reattempt Magento 40X on REST**
    *   **Description**: Retries REST API requests that return 401 or 404 errors, potentially to handle race conditions or temporary unavailability. usage: `req.restarts < 1`.
    *   **Files**: `API helper/reattempt Magento 40X on REST/vcl_fetch`

*   **Reattempt Magento 502**
    *   **Description**: Retries requests that result in a 502 Bad Gateway error from the backend.
    *   **Files**: `API helper/reattempt Magento 502`

## Cache Manipulation

*   **Avoid API Mesh Cache**
    *   **Description**: Bypasses the cache (pass) for specific API Mesh GraphQL requests to ensure fresh data.
    *   **Files**: `Cache Manipulation/Avoid API Mesh Cache/vcl_recv`
