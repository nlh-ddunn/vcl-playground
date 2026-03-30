# Block non-Magento CMS systems
# This snippet blocks common administrative and system paths for popular CMS platforms 
# that are not used by Magento 2. This prevents automated scanners and bots from 
# adding unnecessary load to the origin server.
#
# Supported Platforms:
# - WordPress: (wp-admin, wp-content, wp-includes, wp-json, wp-login.php, xmlrpc.php)
# - Joomla: (administrator, components, libraries, plugins, templates, configuration.php, installation)
# - Drupal: (core, misc, modules, profiles, scripts, themes, update.php, install.php, user/login, user/register, node/add)
# - MediaWiki: (mw-config, LocalSettings.php, api.php, skins, extensions, maintenance)
# - Typo3: (typo3, typo3conf, fileadmin, typo3temp)
# - Ghost: (ghost)
# - Bitrix: (bitrix)

if (req.url.path ~ "(?i)^/(wp-admin|wp-content|wp-includes|wp-json|wp-login\.php|xmlrpc\.php|administrator/|components/|libraries/|plugins/|templates/|configuration\.php|installation/|core/|misc/|modules/|profiles/|scripts/|themes/|update\.php|install\.php|user/login|user/register|node/add|mw-config/|LocalSettings\.php|api\.php|skins/|extensions/|maintenance/|typo3/|typo3conf/|fileadmin/|typo3temp/|ghost/|bitrix/)") {
  # Return a 403 Forbidden since these paths do not exist on a Magento 2 installation.
  error 403;
}
