# As Adobe Edge delivery services use the default surrogate key behavior, this workaround
# corrects expected and intended behavior for the default Magento / Adobe Commerce code
# that will disregard this and prefer content using x-magento-tags headers. This code
# will allow both to function so long as they are not both present. If they both are,
# it will prefer the x-magento-tags values.

if(beresp.http.surrogate-key && !beresp.http.x-magento-tags){
  set beresp.http.x-magento-tags = beresp.http.surrogate-key;
}
