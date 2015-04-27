<ul class="breadcrumb">
	<li><a href="/">Главная</a> <span class="divider grey">&rarr;</span></li>
	{$sUrlMix=''}
	{foreach $aBreadCrumb as $aA name=aB}
		{if $smarty.foreach.aB.last}
			<li>{$aA.title}</li>
		{else}
			<li><a href="/{Config::Get('plugin.admin.url')}/{$sUrlMix}{$aA.url}/">{$aA.title}</a> <span class="divider grey">&rarr;</span></li>
		{/if}
		{$sUrlMix=$sUrlMix|cat:$aA.url|cat:'/'}
	{/foreach}
	{* TODO: Языковик *}
	{if $sEvent == 'error'}Ошибка{/if}
	<span class="divider grey">&darr;</span>
</ul>