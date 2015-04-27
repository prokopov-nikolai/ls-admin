<script type="text/javascript">
	$(function(){
		$('.type-title').click(function(){
			$('input[name="type_title"]').val($(this).html());
			return false;
		});
	});
</script>

<form action="" method="post" onsubmit="ls.plugin.shop.fabric.updateTypeTitle($(this)); return false;">
	{* Название типа *}
	{include file='forms/fields/form.field.text.tpl'
		sFieldName        = 'type_title'
		sFieldValue       = $oFabric->getTypeTitle()|escape:'html'
		sFieldLabel       = 'Тип ткани'}

	{* Название коллекции *}
	{include file='forms/fields/form.field.hidden.tpl'
		sFieldName        = 'collection_title'
		sFieldValue       = $oFabric->getCollectionTitle()|escape:'html'}

	{* Список типов для подстановки *}
	{foreach $aType as $oType}
		<a href="#" class="type-title">{$oType->getTypeTitle()}</a>
	{/foreach}
	<div class="clear" style="height: 20px;"></div>

	{* Сохранить *}
	{include file='forms/fields/form.field.button.tpl'
		sFieldId='submit-update-type-title'
		sFieldClasses='btn btn-primary'
		sFieldText='Сохранить'}
</form>