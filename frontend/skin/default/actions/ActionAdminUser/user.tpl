{extends file="{$aTemplatePathPlugin.admin}layouts/layout.base.tpl"}

{block name='layout_options'}
	{$sMenuSelect = 'user'}
{/block}

{block name='layout_content'}
	{* TODO: Языковик *}
	<h2 class="page-sub-header">{$oUserEdit->getDisplayName()}</h2>
	{include file="{$aTemplatePathPlugin.admin}forms/user.tpl"}
{/block}