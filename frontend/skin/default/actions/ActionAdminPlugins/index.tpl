{extends file="{$aTemplatePathPlugin.admin}layouts/layout.base.tpl"}

{block name='layout_options'}
	{$sMenuSelect = 'plugins'}
{/block}

{block name='layout_content'}
	<h2>{$aLang.plugin.admin.menu.plugins}</h2>
	<form action="{router page='admin'}plugins/" method="post" class="table">
		<table class="table table-plugins">
			<thead>
			<tr>
				<th class="cell-checkbox"><input type="checkbox" name="" onclick="ls.tools.checkAll('form_plugins_checkbox', this, true);" /></th>
				<th>Название плагина</th>
				<th>Версия</th>
				<th>Автор</th>
				<th></th>
			</tr>
			</thead>

			<tbody>
			{foreach $aPlugins as $aPlugin}
				<tr {if $aPlugin.is_active}class="active"{/if}>
					<td class="cell-checkbox"><input type="checkbox" name="plugin_del[{$aPlugin.code}]" class="form_plugins_checkbox" /></td>
					<td>
						<h3>{$aPlugin.property->name->data}</h3>
						{$aPlugin.property->description->data}
					</td>
					<td>{$aPlugin.property->version|escape:'html'}</td>
					<td>
						{$aPlugin.property->author->data}<br />
						{$aPlugin.property->homepage}
					</td>
					<td align="center">
						{if $aPlugin.is_active}
							<a href="{router page='admin'}plugins/?plugin={$aPlugin.code}&action=deactivate&security_ls_key={$LIVESTREET_SECURITY_KEY}" class="button">{$aLang.plugin.admin.plugin.deactivate}</a>
						{else}
							<a href="{router page='admin'}plugins/?plugin={$aPlugin.code}&action=activate&security_ls_key={$LIVESTREET_SECURITY_KEY}" class="button button-primary">{$aLang.plugin.admin.plugin.activate}</a>
						{/if}
					</td>
				</tr>
			{/foreach}
			</tbody>
		</table>

		<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" />
		<input type="submit"
		       name="submit_plugins_del"
		       value="{lang name='plugin.admin.button.delete'}"
		       class="button"
		       onclick="return (jQuery('.form_plugins_checkbox:checked').length==0)?false:confirm('{$aLang.common.remove_confirm}');" />
	</form>
{/block}