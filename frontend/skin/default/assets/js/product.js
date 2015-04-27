/**
 * Плагин админки магазина
 * @type {*|{}}
 */
var ls = ls || {};
ls.plugin = ls.plugin || {};
ls.plugin.shop = ls.plugin.shop || {};

ls.plugin.shop.product =( function ($) {
    /**
     * Обновляем подпись к фото
     * @param form
     */
    this.updateMediaAlt = function(obj) {
        ls.ajax.load(
	        ls.registry.get('sAdminUrl')+'product/ajax/update_media_alt/',
	        {
		        alt: $(obj).val(),
		        id: $(obj).data('media-id')
	        },
	        function(oResponse){
				if (oResponse.bStateError == false) {
					ls.msg.notice(null, oResponse.sMsg);
				} else {
					ls.msg.error('Ошибка', oResponse.sMsg);
				}

            }
        );
	    return false;
    };

	/**
	 * Удаляем фото
	 */
	this.deleteMedia = function(obj){
		ls.ajax.load(
			ls.registry.get('sAdminUrl')+'product/ajax/delete_media/',
			{
				media_id: $(obj).data('media-id'),
				product_id: $(obj).data('product-id')
			},
			function(oResponse){
				if (oResponse.bStateError == false) {
					ls.msg.notice(null, oResponse.sMsg);
					$(obj).parents('li').fadeOut(500, function(){ $(obj).remove(); });
				} else {
					ls.msg.error('Ошибка', oResponse.sMsg);
				}

			}
		);
		return false;
	}

    return this;
}).call(ls.plugin.shop.product || {},jQuery);