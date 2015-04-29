<!DOCTYPE html>
{block name='layout_options'}{/block}
<html lang="ru">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="{block name='layout_description'}{$sHtmlDescription}{/block}">
	<meta name="keywords" content="{block name='layout_keywords'}{$sHtmlKeywords}{/block}">

	<title>{block name='layout_title'}{$sHtmlTitle}{/block}</title>

	<link href='http://fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'>
	{*<link href="{cfg name='path.skin.assets.web'}/images/favicons/favicon.ico?v1" rel="shortcut icon" />*}
	<link href="{cfg name='path.skin.assets.web'}/images/favicons/fav_32.gif?v1" rel="shortcut icon" />
	<link rel="search" type="application/opensearchdescription+xml" href="{router page='search'}opensearch/" title="{cfg name='view.name'}" />

	{**
	 * Стили
	 * CSS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
	 *}
	{$aHtmlHeadFiles.css}
	<!--[if lt IE 9]>
	<link href="{cfg name='path.skin.assets.web'}/css/ie.css" rel="stylesheet" />
	<![endif]-->


	{**
	 * RSS
	 *}
	{if $aHtmlRssAlternate}
		<link rel="alternate" type="application/rss+xml" href="{$aHtmlRssAlternate.url}" title="{$aHtmlRssAlternate.title}">
	{/if}

	{if $sHtmlCanonical}
		<link rel="canonical" href="{$sHtmlCanonical}" />
	{/if}


	<script>
		var		PATH_ROOT 					= '{router page='/'}',
				PATH_SKIN		 			= '{cfg name="path.skin.web"}',
				PATH_FRAMEWORK_FRONTEND		= '{cfg name="path.framework.frontend.web"}',
				PATH_FRAMEWORK_LIBS_VENDOR	= '{cfg name="path.framework.libs_vendor.web"}',

				LIVESTREET_SECURITY_KEY = '{$LIVESTREET_SECURITY_KEY}',
				SESSION_ID				= '{$_sPhpSessionId}',
				SESSION_NAME			= '{$_sPhpSessionName}',
				LANGUAGE				= '{$oConfig->GetValue('lang.current')}',
				WYSIWYG					= {if $oConfig->GetValue('view.wysiwyg')}true{else}false{/if},
				USER_PROFILE_LOGIN		= {if $oUserProfile}{json var=$oUserProfile->getLogin()}{else}''{/if},
				ADMIN_URL               ='{Config::Get('plugin.admin.url')}';

		var aRouter = [];
		{foreach $aRouter as $sPage => $sPath}
		aRouter['{$sPage}'] = '{$sPath}';
		{/foreach}

	</script>

	{**
	 * JavaScript файлы
	 * JS файлы подключаются в конфиге шаблона (ваш_шаблон/settings/config.php)
	 *}
	{$aHtmlHeadFiles.js}

	{block name='layout_head_end'}{/block}
	{hook run='html_head_end'}
</head>
<body class="{$sBodyClasses}">
	<div id="wrapper" class="admin">
		{hook run='body_begin'}
		<div class="container">
			<div class="col-md-9">
				<section>
					{include file="{$aTemplatePathPlugin.admin}breadcrumbs.tpl"}
					{* Основной заголовок страницы *}
					{block name='layout_page_title' hide}
						<h1>{$smarty.block.child}</h1>
					{/block}

					{* Системные сообщения *}
					{if $aMsgError}
						{component 'alert' text=$aMsgError mods='error' close=true}
					{/if}

					{if $aMsgNotice}
						{component 'alert' text=$aMsgNotice close=true}
					{/if}

						{block name='layout_content'}{/block}

					{block name='layout_content_end'}{/block}
				</section>
			</div>
			<div class="col-md-3">
				<aside>
					{if $oUserCurrent}{$oUserCurrent->getDisplayName()}{/if}
					<a href="{router page='login'}exit/?security_ls_key={$LIVESTREET_SECURITY_KEY}">Выйти</a>
					&nbsp;<br>&nbsp;<br>
					<a href="/admin/cache_delete/" id="cache-del">Сбросить кеш</a>
					<nav class="main">
						{foreach $aAdminMenu as $aItem}
							<a href="{$aItem.url}"{if $sMenuSelect == $aItem.menu_key} class="active"{/if}>{LS::E()->Lang_Get($aItem.lang_key)}</a>
							{if $aItem.sub && $sMenuSelect == $aItem.menu_key}
								<nav class="sub">
									{foreach $aItem.sub as $aItem1}
										<a href="{$aItem1.url}"{if $sMenuSelectSub == $aItem1.menu_key} class="active"{/if}>{LS::E()->Lang_Get($aItem1.lang_key)}</a>
									{/foreach}
								</nav>
							{/if}
						{/foreach}
					</nav>
				</aside>
			</div>
		</div>
		<div id="footer_guarantor"></div>
	</div>
	<footer>
		<div class="container"><a href="http://no-be.ru" class="purple">No-Be</a> - <a href="http://no-be.ru" class="purple">сайты под ключ за 5 шагов</a>
			<a class="pull-right" href="http://livestreet.ru">LiveStreet {$LS_VERSION}</a></div>
	</footer>
{$sLayoutAfter}
</body>
</html>
