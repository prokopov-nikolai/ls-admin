<?php

$config['url'] = 'admin';

$config['$root$']['router']['page'][$config['url']] = 'PluginAdmin_ActionAdmin';
$config['$root$']['router']['page'][$config['url'].'_plugins'] = 'PluginAdmin_ActionAdminPlugins';
$config['$root$']['router']['page'][$config['url'].'_user'] = 'PluginAdmin_ActionAdminUser';

$config['admin_menu'] = array();

if (LS::Adm()) {
//	$config['admin_menu'][] = array(
//		'sort' => 90,
//		'url' => '/'.$config['url'].'/user/',
//		'lang_key' => 'plugin.admin.menu.user',
//		'menu_key' => 'user',
//	);
	$config['admin_menu'][] = array(
		'sort' => 100,
		'url' => '/'.$config['url'].'/plugins/',
		'lang_key' => 'plugin.admin.menu.plugins',
		'menu_key' => 'plugins'
	);

}
return $config;