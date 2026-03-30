# vcl-playground
This is a collection of VCL snippets for addressing commonly encountered issues on Magento / Adobe Commerce with Fastly kept in a repository for quick and easy use and reuse.

These snippets are added on an as-needed basis when VCL code needs to be reused across projects, rather than writing one-off solutions. Because they are not designed to work as a unified suite, no effort has been made to prevent overlapping error codes or namespace collisions. Furthermore, implementing them on live environments may necessitate adjustments or updates.

Note: some snippets act in ways to treat symptoms of issues and may cause entirely different ones (such as API re-attempts) which may allow the front-end to appear more responsive and less error prone at the expense of additional load on the backend and degraded stability and performance.  Please do not implement snippets on a live site without proper testing and understanding of the potential impact.

# VCL Snippets Listing

This directory outlines the available VCL configurations within the `vcl-playground` repository and explains their intended functionality.

## AI Bots

*   **Block Based on Cache State**
    *   **Description**: Identifies and drops bot traffic by inspecting user-agents specifically when they request uncached resources. This approach reduces unnecessary strain on the origin server without completely barring legitimate bot crawling behavior.
    *   **Files**: `AI Bots/block based on cache state/` (`vcl_init.vcl`, `vcl_fetch.vcl`)

*   **Block Based on Query String**
    *   **Description**: Rejects incoming requests that include specific query string parameters commonly favored by disruptive or unwanted bot traffic.
    *   **Files**: `AI Bots/block based on query string/` (`vcl_init.vcl`, `vcl_recv.vcl`)

## API Helper

*   **Reattempt Magento 40X on REST**
    *   **Description**: Attempts to fetch REST API resources an additional time if the origin returns a 401 or 404 response. This helps smooth out race conditions or momentary unavailability. Usage: `req.restarts < 1`.
    *   **Files**: `API helper/reattempt Magento 40X on REST/vcl_fetch.vcl`

*   **Reattempt Magento 502**
    *   **Description**: Forces the edge to try again whenever the backend responds with a 502 Bad Gateway error.
    *   **Files**: `API helper/reattempt Magento 502/vcl_fetch.vcl`

## Attacks and Nuisance Traffic

*   **Ban Abused Carts**
    *   **Description**: Declines traffic attempting to interact with specific shopping cart IDs that have been proven to be abused. The targeted cart IDs are maintained in a dedicated VCL table.
    *   **Files**: `Attacks and nuisance traffic/Ban Abused Carts from Adobe Commerce or Magento/` (`vcl_init.vcl`, `vcl_recv.vcl`)

*   **Block Session Reaper + Polyshell**
    *   **Description**: Safeguards against session reaper attacks and unauthorized file uploads by restricting access to `/customer/address_file/upload` exclusively to allowed client IP addresses. It also blocks Polyshell, which let's be honest, is just sessionreaper in a trenchcoat.
    *   **Files**: `Attacks and nuisance traffic/Block Session Reaper + Polyshell/` (`vcl_init.vcl`, `vcl_recv.vcl`)

*   **Block Drupal Paths**
    *   **Description**: Prevents automated scanners from hitting common Drupal framework routes (like `core`, `user/login`, and `update.php`) by returning a 403 Forbidden. This eliminates unnecessary load on origin servers that do not run Drupal.
    *   **Files**: `Attacks and nuisance traffic/Block Drupal paths/vcl_recv.vcl`

*   **Block Exchange Server Requests**
    *   **Description**: Halts traffic directed at Microsoft Exchange Server endpoints (e.g., `autodiscover`, `owa`). These paths are frequently targeted by vulnerability scanners and misconfigured email clients and add avoidable overhead to the backend.
    *   **Files**: `Attacks and nuisance traffic/Block Exchange Server Requests/vcl_recv.vcl`

*   **Block Obsolete Browsers**
    *   **Description**: Blocks traffic originating from browser versions that are identified as outdated.
    *   **Files**: `Attacks and nuisance traffic/Block Obsolete Browsers/` (`vcl_init`, `vcl_recv`, `vcl_err`)

*   **Block Traffic per ISP**
    *   **Description**: Restricts access from particular Internet Service Providers by evaluating the `client.as.name` variable.
    *   **Files**: `Attacks and nuisance traffic/Block traffic per ISP/vcl_recv.vcl`

*   **Block WordPress Paths**
    *   **Description**: Stops requests looking for standard WordPress paths (such as `wp-admin`, `wp-login.php`, or `xmlrpc.php`) before they reach the backend, returning a 403 Forbidden. This saves resources on servers that do not run WordPress.
    *   **Files**: `Attacks and nuisance traffic/Block WordPress paths/vcl_recv.vcl`

## Avoidable 404s

*   **Define Missing Favicon/Apple Icon**
    *   **Description**: Captures calls for missing standard interface icons (e.g., `favicon.ico`, `apple-touch-icon.png`, `android-chrome-*.png`, `mstile-*.png`, `safari-pinned-tab.svg`) using a regular expression and routes them to a canonical location, mitigating frequent 404 errors.
    *   **Files**: `Avoidable 404s/Define missing favicon.ico and apple/vcl_recv.vcl`

*   **Missing Favicon with Fastly IO**
    *   **Description**: Leverages the Fastly Image Optimizer (Fastly IO) to dynamically encode and resize a default `favicon.png` fallback into platform-specific dimensions (Apple Touch, Android Chrome, Windows mstile). It rigidly enforces correct MIME types upon delivery and silently synthesizes an empty cached placeholder if the origin throws a 404. **Warning: This code suite is currently experimental and has not been fully tested in production environments.**
    *   **Files**: `Avoidable 404s/Missing Favicon with Fastly IO/` (`vcl_recv.vcl`, `vcl_fetch.vcl`, `vcl_deliver.vcl`, `vcl_error.vcl`)

*   **Lockdown Media Contents**
    *   **Description**: Analyzes requests for `/(index.php/)?media/` elements. Unused caching variations are prevented by stripping extraneous URL parameters, maintaining only those necessary for Fastly IO. Additionally, missing 404 media image requests (validated by their file extension) are prevented from triggering large, unoptimized HTML 404 responses from the backend, and instead directly serve a synthetic 32x32 red "X" from the Edge cache with a 1-hour TTL.
    *   **Files**: `Avoidable 404s/Lockdown Media Contents/` (`vcl_recv.vcl`, `vcl_fetch.vcl`, `vcl_error.vcl`)

## Cache Manipulation

*   **Avoid API Mesh Cache**
    *   **Description**: Ensures fresh data retrieval by configuring specific API Mesh GraphQL requests to bypass the edge cache layer ('pass').
    *   **Files**: `Cache Manipulation/Avoid API Mesh Cache/vcl_recv.vcl`

*   **Force Caching on Backends**
    *   **Description**: Enforces a default time-to-live (TTL) boundary by injecting caching headers on backend responses that omit proper expiry details.
    *   **Files**: `Cache Manipulation/Force caching on backends that do not send proper expiry/vcl_fetch.vcl`

## Header Manipulation

*   **Fix-GeoIP**
    *   **Description**: Replaces the default Fastly GeoIP lookup key by checking for proprietary headers (`True-Client-IP` from Akamai/Cloudflare, `Incap-Client-IP` from Imperva), with a graceful fallback to extracting the original client IP from the `X-Forwarded-For` header.
    *   **Files**: `Header Manipulation/Fix-GeoIP/vcl_recv.vcl`


*   **Force Content-Security-Policy to Report-Only**
    *   **Description**: Safely tests CSP parameters by downgrading a restrictive `Content-Security-Policy` header into an informational `Content-Security-Policy-Report-Only` header, preserving site functionality during the tuning phase.
    *   **Files**: `Header Manipulation/Force Content-Security-Policy to report-only/vcl_fetch.vcl`

*   **Override CORS for Commerce Cloud**
    *   **Description**: Facilitates targeted Cross-Origin Resource Sharing (CORS) overrides for designated URLs on specified domains, relying on mapped VCL tables (`cors_allowed` and `urls_to_override`).
    *   **Files**: `Header Manipulation/Override CORS for Commerce Cloud/` (`vcl_deliver.vcl`, `vcl_init.vcl`)

*   **Override CORS for Commerce Cloud API Mesh**
    *   **Description**: Reconfigures and validates CORS headers explicitly for API Mesh transactions against an approved baseline.
    *   **Files**: `Header Manipulation/Override CORS for Commerce Cloud API Mesh/` (`vcl_init.vcl`, `vcl_deliver.vcl`)

*   **Patch to Correct Damaged Surrogate-Keys on Edge Delivery Services**
    *   **Description**: Provides a workaround for Adobe Edge Delivery Services behavior. The logic falls back to existing `surrogate-key` variables if an `x-magento-tags` header is absent, letting both architectures operate as intended.
    *   **Files**: `Header Manipulation/Patch to correct damaged surrogate-keys on Edge Delivery Services/vcl_fetch.vcl`

*   **Spoof the Via Header**
    *   **Description**: Alters the `Via` header, commonly configured either to obscure upstream proxies from public view or to fulfill internal network routing conventions.
    *   **Files**: `Header Manipulation/Spoof the via header/vcl_deliver.vcl`

*   **Strip All But First IP from X-Forwarded-For**
    *   **Description**: Extracts and preserves solely the original client's IP from the `X-Forwarded-For` header chain. This update accommodates both IPv4 and IPv6 protocols by separating addresses cleanly with commas, passing the true client IP back to the origin.
    *   **Files**: `Header Manipulation/Strip all but the first IP from x-forwarded-for/vcl_recv.vcl`

## URL Manipulation

*   **Add Trailing Slash**
    *   **Description**: Intercepts URIs lacking a terminal slash and rewrites or redirects them to include it, thereby enforcing standard URL consistency.
    *   **Files**: `URL Manipulation/Add Trailing Slash/` (`vcl_recv.vcl`, `vcl_error.vcl`)

*   **ApplePay Verification**
    *   **Description**: Serves ApplePay domain verification files directly.
    *   **Files**: `URL Manipulation/ApplePay Verification/vcl_recv.vcl`

*   **ApplePay via Synthetic Multisite**
    *   **Description**: Sets up synthetic responses for ApplePay verification tasks in more complex, multi-site deployments.
    *   **Files**: `URL Manipulation/ApplePay via Synthetic multisite example/` (`vcl_recv.vcl`, `vcl_err.vcl`, `vcl_init.vcl`)

*   **Filter Marketing Parameters**
    *   **Description**: Boosts cache hit ratios by stripping out common marketing, tracking, and analytics indicators (such as `utm_`, `gclid`, `fbclid`, etc.) from request query strings, and safely normalizing the remaining parameters by sorting them.
    *   **Files**: `URL Manipulation/Filter Marketing Parameters/vcl_recv.vcl`
