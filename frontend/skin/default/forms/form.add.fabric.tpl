<script type="text/javascript">
	$(function(){
		$('#submit-add-fabric').bind('click', function(){
			$('#form-add-fabric .dn').slideToggle();
			$('#submit-add-fabric').unbind('click');
			return false;
		});
	});
</script>


<div class="cl" style="height: 20px;"></div>
<form action="" method="post" enctype="multipart/form-data"  onsubmit="ls.plugin.shop.fabric.addFabric($(this)); return false;" id="form-add-fabric">
	<div class="dn">
		{* Название коллекции *}
		{if $bTypeHidden === true}
			{include file='forms/fields/form.field.hidden.tpl'
				sFieldName        = 'fabric[collection_title]'
				sFieldValue       = $oFabric->getCollectionTitle()}
		{else}
			{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'fabric[collection_title]'
				sFieldValue       = ''
				sFieldLabel       = 'Название коллекции'}
		{/if}

		{* Название ткани *}
		{include file='forms/fields/form.field.text.tpl'
			sFieldName        = 'fabric[title]'
			sFieldLabel       = 'Название ткани'}

		{* Изображение *}
		{include file='forms/fields/form.field.file.tpl'
			sFieldName        = 'fabric_file'
			sFieldLabel       = 'Выберите изображение'}

		{* Ссылка на изображение *}
		{include file='forms/fields/form.field.text.tpl'
			sFieldName        = 'fabric_url'
			sFieldLabel       = 'Или укажите ссылка на изображение'}
	</div>

	{* Название типа ткани *}
	{include file='forms/fields/form.field.hidden.tpl'
		sFieldName        = 'fabric[type_title]'
		sFieldValue       = $oFabric->getTypeTitle()}

	{* Айди группы *}
	{include file='forms/fields/form.field.hidden.tpl'
		sFieldName        = 'fabric[group_id]'
		sFieldValue       = $oGroup->getId()}

	{* Сохранить *}
	{include file='forms/fields/form.field.button.tpl'
		sFieldId='submit-add-fabric'
		sFieldClasses='btn btn-primary'
		sFieldText='Добавить ткань'}
</form>