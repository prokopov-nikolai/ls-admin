{extends file="{$aTemplatePathPlugin.admin}layouts/layout.base.tpl"}

{block name='layout_options'}
	{$bNoSystemMessages = true}
{/block}

{block name='layout_page_title'}
	{if $aMsgError[0].title}
		{$aLang.error}: <span>{$aMsgError[0].title}</span>
	{/if}
{/block}

{block name='layout_content'}
	<p>{$aMsgError[0].msg}</p>
	<p>
		<a href="javascript:history.go(-1);">{$aLang.site_history_back}</a>,
		<a href="{Config::Get('path.root.web')}">{$aLang.site_go_main}</a>
	</p>
{/block}