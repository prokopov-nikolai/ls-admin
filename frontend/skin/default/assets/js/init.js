$(function(){
	/**
	 * Урл админки
	 */
	ls.registry.set('sAdminUrl', '/admin/');
	/**
	 * Иниц-ия модулей ядра
	 */
	ls.init({
		production: false
	});
	/**
	 * Редактор
	 */
	$('.js-editor-default').lsEditor();
});