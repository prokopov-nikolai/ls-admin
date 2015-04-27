<ul>
	{foreach $aUser as $oU}
		<li>
			<a href="/{Config::Get('plugin.admin.url')}/user/edit/{$oU->getId()}/">{$oU->getMail()}</a>
		</li>
	{/foreach}
</ul>