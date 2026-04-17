# blocks traffic per the ISP name
# these can be found on sites like bgpview.io

# https://developer.fastly.com/reference/vcl/variables/client-connection/client-as-name/

# Common abusive hosting providers (ASN Names):
# 1.  DigitalOcean, LLC          | https://www.abuseipdb.com/asn/14061 | https://bgpview.io/asn/14061
# 2.  Hetzner Online GmbH        | https://www.abuseipdb.com/asn/24940 | https://bgpview.io/asn/24940
# 3.  OVH SAS                    | https://www.abuseipdb.com/asn/16276 | https://bgpview.io/asn/16276
# 4.  M247 Ltd                   | https://www.abuseipdb.com/asn/9009  | https://bgpview.io/asn/9009
# 5.  Akamai Technologies (Linode) | https://www.abuseipdb.com/asn/63949 | https://bgpview.io/asn/63949
# 6.  Hostinger Intl Ltd         | https://www.abuseipdb.com/asn/47583 | https://bgpview.io/asn/47583
# 7.  Choopa, LLC (Vultr)        | https://www.abuseipdb.com/asn/20473 | https://bgpview.io/asn/20473
# 8.  Leaseweb Germany GmbH      | https://www.abuseipdb.com/asn/16265 | https://bgpview.io/asn/16265
# 9.  Contabo GmbH               | https://www.abuseipdb.com/asn/51167 | https://bgpview.io/asn/51167
# 10. QuadraNet Enterprises LLC  | https://www.abuseipdb.com/asn/8100  | https://bgpview.io/asn/8100


if (std.tolower(client.as.name) ~ "ISP Name") {
  error 403;
}

