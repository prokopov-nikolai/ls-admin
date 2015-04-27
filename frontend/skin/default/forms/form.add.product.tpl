<script type="text/javascript">
	$(function(){
		{if !$oProductCurrent}
			$('#submit-{$bAction}-product').bind('click', function(){
				$('#form-{$bAction}-product .dn').slideToggle();
				$('#submit-{$bAction}-product').unbind('click');
				return false;
			});
		{/if}
		/**
		 * Переключение вкладок
		 */
		$('.nav.nav-tabs a').tab();
		/**
		 * Активируем нужную вкладку
		 */
		if (window.location.hash != '#') {
			$($('.nav-tabs li a')[parseInt(window.location.hash.substr(1),10)-1]).click();
		}
		/**
		 * Вешаем событие на обновление подписи к фото
		 */
		$('.js-input-media_alt').bind('blur', function(){
			ls.plugin.shop.product.updateMediaAlt(this);
		});
		/**
		 * Вешаем событие на удаление фото
		 */
		$('.media_items .delete').bind('click', function(){
			ls.plugin.shop.product.deleteMedia(this);
			return false;
		});
	});
</script>

{* Подключение редактора *}
{if $bRedactorInit === true}
	{include 'forms/editor.init.tpl' sEditorSelector='text-add, .text-update' sMediaTargetType='category'}
{/if}

<div class="cl" style="height: 20px;"></div>
<form action="" method="post" enctype="multipart/form-data" id="form-{$bAction}-product">
	<div class="{if !$oProductCurrent}dn{/if}">
		<ul class="nav nav-tabs">
			<li class="active"><a href="#tab1-{$bAction}" onclick="window.location.hash='#1'">Описание</a></li>
			<li><a href="#tab2-{$bAction}" onclick="window.location.hash='#2'">Seo</a></li>
			<li><a href="#tab3-{$bAction}" onclick="window.location.hash='#3'">Доп. опции</a></li>
			<li><a href="#tab4-{$bAction}" onclick="window.location.hash='#4'">Характеристики</a></li>
			<li><a href="#tab5-{$bAction}" onclick="window.location.hash='#5'">Цены и ставки</a></li>
			<li><a href="#tab6-{$bAction}" onclick="window.location.hash='#6'">Изображения</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="tab1-{$bAction}">
				{* Категория *}
				{include file='forms/fields/form.field.select.tpl'
				sFieldName        = 'product[category_id]'
				sFieldLabel       = 'Категория'
				aFieldItems       = $aCategorySelect
				sFieldSelectedValue= {($oProductCurrent) ? $oProductCurrent->getCategoryId() : $iCategoryId}}

				{* Производитель *}
				{include file='forms/fields/form.field.select.tpl'
				sFieldName        = 'product[make_id]'
				sFieldLabel       = 'Производитель'
				aFieldItems       = $aMakeSelect
				sFieldSelectedValue= {($oProductCurrent) ? $oProductCurrent->getMakeId() : $iMakeId}}

				{* Название *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[name]'
				sFieldLabel       = 'Название товара'
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getName() : ''}}

				{* Урл *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[url]'
				sFieldLabel       = 'Урл товара'
				bFieldIsDisabled  = true
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getUrlFull() : ''}}

				{* Урл *}
				{include file='forms/fields/form.field.hidden.tpl'
				sFieldName        = 'product[url]'
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getUrl() : ''}}

				{* Описание *}
				{include file='forms/fields/form.field.textarea.tpl'
				sFieldName        = 'product[text]'
				sFieldLabel       = 'Описание'
				sFieldClasses     = 'width-full text-'|cat:$bAction
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getText() : ''}}

				{* Сортировка *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[sort]'
				sFieldLabel       = 'Сортировка'
				sFieldValue       = {($oProductCurrent && $oProductCurrent->getSort()) ? $oProductCurrent->getSort() : '0'}}

				{* Скрыть *}
				{include file='forms/fields/form.field.checkbox.tpl'
				sFieldName        = 'product[hide]'
				sFieldLabel       = 'Скрыть товар'
				sFieldValue       = 1
				bFieldChecked     = {($oProductCurrent && $oProductCurrent->getHide()) ? true : false}}

				{* Просмотры *}
				<label for="product[view]" class="form-field-label">Количество просмотров:</label><br>
				{($oProductCurrent) ? $oProductCurrent->getViews() : '0'}

			</div>
			<div class="tab-pane" id="tab2-{$bAction}">
				{* title *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[title]'
				sFieldLabel       = 'Title страницы товара'
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getTitle() : ''}}

				{* keywords *}
				{include file='forms/fields/form.field.textarea.tpl'
				sFieldName        = 'product[keywords]'
				sFieldLabel       = 'Keywords'
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getKeywords() : ''}}

				{* description *}
				{include file='forms/fields/form.field.textarea.tpl'
				sFieldName        = 'product[description]'
				sFieldLabel       = 'Description'
				sFieldValue       = {($oProductCurrent) ? $oProductCurrent->getDescription() : ''}|escape:'html'}
			</div>
			<div class="tab-pane" id="tab3-{$bAction}">
				{*{$oProductCurrent->getOpts()|pr}*}
				{foreach $aOpt as $oOpt}
					{* Опции *}
					{$bFieldChecked=false}
					{if $oProductCurrent}
						{foreach $oProductCurrent->getOpts() as $oO}
							{if $oO->getId() == $oOpt->getId()}{$bFieldChecked=true}{/if}
						{/foreach}
					{/if}
					{include file='forms/fields/form.field.checkbox.tpl'
					sFieldName        = 'product[opt]['|cat:$oOpt->getId()|cat:']'
					sFieldLabel       = $oOpt->getTitle()|cat:'('|cat:$oOpt->getPrice()|cat:')'
					bFieldChecked     = $bFieldChecked
					sFieldValue       = $oOpt->getKey()}
				{/foreach}
			</div>
			<div class="tab-pane" id="tab4-{$bAction}">
				{if $oCategory}
					{foreach $oCategory->getChars() as $oChar}
						{if $oChar->getType() == 0}
							{$mCharValue=($oProductCurrent) ? $oProductCurrent->getCharValueById($oChar->getId()): ''}
							{include file='forms/fields/form.field.text.tpl'
							sFieldName        = 'product[char]['|cat:{$oChar->getId()}|cat:']'
							sFieldLabel       = $oChar->getTitle()
							sFieldValue       = $mCharValue}
						{elseif $oChar->getType() == 1}
							{$mCharValue=($oProductCurrent) ? $oProductCurrent->getCharValueById($oChar->getId()): ''}
							{$mCharValue=$mCharValue|translit}
							{$mCharValue|pr}
							{include file='forms/fields/form.field.select.tpl'
							sFieldName        = 'product[char]['|cat:{$oChar->getId()}|cat:']'
							sFieldLabel       = $oChar->getTitle()
							aFieldItems       = $oChar->getSelectValues()
							sFieldSelectedValue= $mCharValue}
						{/if}
					{/foreach}
				{/if}
			</div>
			<div class="tab-pane" id="tab5-{$bAction}">
				{* Закупка *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[price_cost]'
				sFieldLabel       = 'Закупка'
				sFieldValue       = {($oProductCurrent && $oProductCurrent->getPriceCost()) ? $oProductCurrent->getPriceCost() : '0.00'}}

				{* Наценка *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[margin]'
				sFieldLabel       = 'Наценка'
				sFieldValue       = {($oProductCurrent && $oProductCurrent->getMargin()) ? $oProductCurrent->getMargin() : '0.00'}}

				{* Ставка Яндекс Маркет *}
				{include file='forms/fields/form.field.text.tpl'
				sFieldName        = 'product[bid]'
				sFieldLabel       = 'Ставка Яндекс Маркет'
				sFieldValue       = {($oProductCurrent && $oProductCurrent->getBid()) ? $oProductCurrent->getBid() : '10'}}

				<label for="product[price_min]" class="form-field-label">Минимальная розничная цена:</label><br>
				{($oProductCurrent) ? $oProductCurrent->getPriceMin(true): ''}
			</div>
			<div class="tab-pane" id="tab6-{$bAction}">
				<label for="">
					Загрузить новое фото:<br>
					<input type="file" name="media" style="margin-top: 10px;"/>
				</label>

				<ul class="media_items" style="padding-top: 40px;">
					{if $oProductCurrent}
						{foreach $oProductCurrent->getMediaItems() as $oMedia}
							<li>
								{*{$oMedia->getData('alt')|pr}*}
								{$aData = $oMedia->getData()}
								<img src="{$oMedia->getFileWebPath()}" alt="" style="max-width: 200px; margin-right: 40px; float: left;"/>
								<a class="delete" href="#del"  data-media-id="{$oMedia->getId()}"  data-product-id="{$oProductCurrent->getId()}"></a>
								<label for="media_alt" class="form-field-label">Подпись к фото:</label><br>
								<input type="text" class="js-input-media_alt" name="media_alt" value="{$oMedia->getDataOne('alt')}" data-media-id="{$oMedia->getId()}">
							</li>
						{/foreach}
					{/if}
				</ul>
			</div>
		</div>
		<div class="cl" style="height: 20px;"></div>
	</div>

	{* Айди товара *}
	{if $bAction === 'update'}
		{include file='forms/fields/form.field.hidden.tpl'
			sFieldName        = 'product[id]'
			sFieldValue       = $oProductCurrent->getId()}
	{/if}


	{include file='forms/fields/form.field.hidden.tpl'
		sFieldName        = 'action'
		sFieldValue       = $bAction}

	{* Сохранить *}
	{if $bAction === 'update'}{$sButtonText = 'Редактировать товар'}{else}{$sButtonText = 'Добавить товар'}{/if}
	{include file='forms/fields/form.field.button.tpl'
		sFieldId        ='submit-'|cat:$bAction|cat:'-product'
		sFieldClasses   ='btn btn-primary'
		sFieldText      =$sButtonText}

	{if $bAction === 'update'}
		<a href="/admin/product/del/{$oProductCurrent->getId()}/" class='btn btn-danger fl-r' style="text-decoration: none;">Удалить</a>
	{/if}
</form>
<div class="cl" style="height: 20px;"></div>
