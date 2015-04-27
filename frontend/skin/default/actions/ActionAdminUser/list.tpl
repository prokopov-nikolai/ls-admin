{extends file="{$aTemplatePathPlugin.admin}layouts/layout.base.tpl"}

{block name='layout_options'}
	{$sMenuSelect = 'user'}
{/block}

{block name='layout_content'}
	{* TODO: Языковик *}
	<h2 class="page-sub-header">Пользователи</h2>
	{include file="{$aTemplatePathPlugin.admin}user/list.tpl"}
	{component 'pagination' total=+$paging.iCountPage current=+$paging.iCurrentPage url="{$paging.sBaseUrl}/page__page__/{$paging.sGetParams}" showPager="true"}
{/block}