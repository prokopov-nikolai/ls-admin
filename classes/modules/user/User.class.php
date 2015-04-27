<?php

class PluginAdmin_ModuleUser extends PluginAdmin_Inherit_ModuleUser
{

	public function Update(ModuleUser_EntityUser $oUser)
	{
		parent::Update($oUser);
		if ($oUser->getManager() == 1){
			$this->Rbac_AddRoleToUser('manager', $oUser);
		}
		if ($oUser->getManager() == 0){
			$oRole = $this->Rbac_GetRoleByCode('manager');
			$oRoleUser = $this->Rbac_GetRoleUserByFilter(array(
				'role_id' => $oRole->getId(),
				'user_id' => $oUser->getId())
			);
			if ($oRoleUser) $oRoleUser->Delete();
		}
		if ($oUser->getSiteOwner() == 1){
			$this->Rbac_AddRoleToUser('site_owner', $oUser);
		}
		if ($oUser->getSiteOwner() == 0){
			$oRole = $this->Rbac_GetRoleByCode('site_owner');
			$oRoleUser = $this->Rbac_GetRoleUserByFilter(array(
					'role_id' => $oRole->getId(),
					'user_id' => $oUser->getId())
			);
			if ($oRoleUser) $oRoleUser->Delete();
		}
	}
}