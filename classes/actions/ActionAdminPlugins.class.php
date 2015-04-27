<?php
/**
 * От этого класса должны быть унаследованы все екшены плагинов,
 * которые нужно интегрировать в админку
 */

class PluginAdmin_ActionAdminPlugins extends PluginAdmin_ActionPlugin
{

	/**
	 * Инициализация
	 */
	public function Init()
	{
		parent::Init();
	}

	public function RegisterEvent()
	{
		$this->AddEvent('', 'EventIndex');
	}

	public function EventIndex()
	{
		/**
		 * Обработка удаления плагинов
		 */
		if (isPost('submit_plugins_del')) {
			$this->Security_ValidateSendForm();

			$aPluginsDelete=getRequest('plugin_del');
			if (is_array($aPluginsDelete)) {
				$this->Plugin_Delete(array_keys($aPluginsDelete));
			}
		}
		/**
		 * Получаем название плагина и действие
		 */
		if($sPlugin=getRequestStr('plugin',null,'get') and $sAction=getRequestStr('action',null,'get')) {
			return $this->SubmitManagePlugin($sPlugin,$sAction);
		}
		/**
		 * Получаем список блогов
		 */
		$aPlugins=$this->PluginManager_GetPluginsItems(array('order'=>'name'));

		/**
		 * Загружаем переменные в шаблон
		 */
		$this->Viewer_Assign("aPlugins",$aPlugins);
		$this->Viewer_AddHtmlTitle($this->Lang_Get('admin.plugins.title'));
		/**
		 * Устанавливаем шаблон вывода
		 */
		$this->AppendBreadCrumb(10, $this->Lang_Get('plugin.admin.menu.plugins'));
		$this->SetTemplateAction('index');
	}
	/**
	 * Активация\деактивация плагина
	 *
	 * @param string $sPlugin	Имя плагина
	 * @param string $sAction	Действие
	 */
	protected function SubmitManagePlugin($sPlugin,$sAction) {
		$this->Security_ValidateSendForm();
		if(!in_array($sAction,array('activate','deactivate','remove','apply_update'))) {
			$this->Message_AddError($this->Lang_Get('admin.plugins.notices.unknown_action'),$this->Lang_Get('error'),true);
			Router::Location(Router::GetPath('admin/plugins'));
		}
		$bResult=false;
		/**
		 * Активируем\деактивируем плагин
		 */
		if ($sAction=='activate') {
			$bResult=$this->PluginManager_ActivatePlugin($sPlugin);
		} elseif ($sAction=='deactivate') {
			$bResult=$this->PluginManager_DeactivatePlugin($sPlugin);
		} elseif ($sAction=='remove') {
			$bResult=$this->PluginManager_RemovePlugin($sPlugin);
		} elseif ($sAction=='apply_update') {
			$this->PluginManager_ApplyPluginUpdate($sPlugin);
			$bResult=true;
		}
		if($bResult) {
			if ($sAction=='activate') {
				$this->Message_AddNotice('Плагин успешно активирован', 'Внимание', true);
			} elseif ($sAction=='deactivate') {
				$this->Message_AddNotice('Плагин успешно деактивирован', 'Внимание', true);
			} elseif ($sAction=='remove') {
				$this->Message_AddNotice('Плагин успешно удален', 'Внимание', true);
			}
		} else {
			if(!($aMessages=$this->Message_GetErrorSession()) or !count($aMessages)) $this->Message_AddErrorSingle('Системная ошибка', 'Ошибка',true);
		}
		/**
		 * Возвращаем на страницу управления плагинами
		 */
		Router::Location(Router::GetPath('admin').'plugins/');
	}
}