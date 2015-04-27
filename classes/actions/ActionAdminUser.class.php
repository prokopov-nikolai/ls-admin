<?php

class PluginAdmin_ActionAdminUser extends PluginAdmin_ActionPlugin
{

	public function Init()
	{
		parent::Init();
		$this->AppendBreadCrumb(10, $this->Lang_Get('plugin.admin.menu.user'), 'user');
	}

	/**
	 * Регистрируем евенты
	 *
	 */
	protected function RegisterEvent()
	{
		/**
		 * Для ajax регистрируем внешний обработчик
		 */
		$this->RegisterEventExternal('AjaxUser', 'PluginAdmin_ActionUser_EventAjax');
		/**
		 * Покупатели
		 */
		$this->AddEventPreg('/^(page([\d]+))?$/i', 'UserList');
		$this->AddEventPreg('/^edit$/', '/^([\d]+)$/i', 'UserEdit');
		/**
		 * ajax
		 */
//	    $this->AddEventPreg('/^ajax$/i', '/^update_media_alt/i', 'AjaxUser::UpdateMediaAlt');
	}

	/**
	 * Список покупателей
	 */
	public function UserList()
	{
		$iPage = $this->GetEventMatch(2, 0);
		$iPage = (!$iPage ? 1 : $iPage);
		$aResult = $this->User_GetUserItemsByFilter(array('#page' => array($iPage, 20)));
		$this->Viewer_Assign('aUser', $aResult['collection']);
		$aPaging = $this->Viewer_MakePaging($aResult['count'], $iPage, 20, Config::Get('pagination.pages.count'), '/admin/user/');
		$this->Viewer_Assign('paging', $aPaging);
		$this->SetTemplateAction('list');
	}

	/**
	 * Выводим данные по пользователю
	 */
	public function UserEdit()
	{
		$oUser = $this->User_GetUserById($this->GetParamEventMatch(0, 0));
		$this->UserSubmit($oUser);
		/**
		 * Получим пользователя по айди из урла
		 */
		$this->AppendBreadCrumb(20, ($oUser->getDisplayName() ? $oUser->getDisplayName() : $oUser->getLogin()), '');
		$this->Viewer_Assign('oUserEdit', $oUser);
		/**
		 * Справочники сайтов и клиентов
		 */
		$this->Viewer_Assign('aSiteForSelect', $this->PluginSb_Site_GetSiteForSelect());
		$this->Viewer_Assign('aKlientForSelect', $this->PluginSb_Klient_GetKlientForSelect());
		/**
		 * Идентификаторы site_id и klient_id для site_owner
		 */
		foreach($oUser->getUserFieldValues(true, 'site_owner') as $oUserField) {
			if ($oUserField->getName() == 'site_id') $this->Viewer_Assign('iSiteId', $oUserField->getValue());
			if ($oUserField->getName() == 'klient_id') $this->Viewer_Assign('iKlientId', $oUserField->getValue());
		}

		$this->SetTemplateAction('user');
	}

	private function UserSubmit($oUser)
	{
		if (isPost()) {
			$oUser->setProfileName(getRequestStr('user_profile_name'));
			if (getRequestStr('role') == 'manager') {
				$oUser->setManager(1);
			} else {
				$oUser->setManager(0);
			}
			if (getRequestStr('role') == 'site_owner') {
				$oUser->setSiteOwner(1);
			} else {
				$oUser->setSiteOwner(0);
			}
			if (getRequestStr('role') == 'admin') {
				$oUser->setAdmin(1);
			} else {
				$oUser->setAdmin(0);
			}
			/**
			 * Обновим значения полей пользователя
			 */
			$aFields = $this->User_getUserFields('site_owner');
			$aData = array();
			foreach ($aFields as $iId => $aField) {
				if ($oUser->getSiteOwner() == 0){
					$aData[$iId] = 0;
				} else if (isset($_REQUEST['profile_user_field_' . $iId])) {
					$aData[$iId] = getRequestStr('profile_user_field_' . $iId);
				} else {
					$aData[$iId] = 0;
				}
			}
			$this->User_setUserFieldsValues($oUser->getId(), $aData);
			/**
			 * Обновим самого пользователя
			 */
			$this->User_Update($oUser);
			$this->Message_AddNoticeSingle('Успешно обновлено', 'Внимание');
		}
	}
}