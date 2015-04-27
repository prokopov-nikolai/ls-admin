<?php
/**
 * Запрещаем напрямую через браузер обращение к этому файлу.
 */
if (!class_exists('Plugin')) {
	die('Hacking attempt!');
}

class PluginAdmin extends Plugin
{
	/**
	 * Наследование сущностей
	 * @var array
	 */
	protected $aInherits=array(
		'entity' => array(
			'ModuleUser_EntityUser' => 'PluginAdmin_ModuleUser_EntityUser'
		),
		'module' => array(
			'ModuleUser' => 'PluginAdmin_ModuleUser'
		)
	);

	public function Activate()
	{
		return true;
	}

	/**
	 * Инициализация плагина
	 */
	public function Init()
	{
	}
}