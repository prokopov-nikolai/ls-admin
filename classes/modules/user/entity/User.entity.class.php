<?php

class PluginAdmin_ModuleUser_EntityUser extends PluginAdmin_Inherit_ModuleUser_EntityUser
{

	public function getManager()
	{
		if (isset($this->_aData['user_manager'])) {
			return $this->_aData['user_manager'];
		}
		$aRole = $this->Rbac_GetRolesByUser($this);
		foreach ($aRole as $oRole) {
			if ($oRole->getCode() == 'manager') return 1;
		}
		return 0;
	}

	public function setManager($iValue)
	{
		$this->_aData['user_manager'] = $iValue;
	}

	public function getSiteOwner()
	{
		if (isset($this->_aData['user_site_owner'])) {
			return $this->_aData['user_site_owner'];
		}
		$aRole = $this->Rbac_GetRolesByUser($this);
		foreach ($aRole as $oRole) {
			if ($oRole->getCode() == 'site_owner') return 1;
		}
		return 0;
	}

	public function setSiteOwner($iValue)
	{
		$this->_aData['user_site_owner'] = $iValue;
	}

}