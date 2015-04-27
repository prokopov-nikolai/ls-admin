/**
 * Плагин админки магазина
 * @type {*|{}}
 */
var ls = ls || {};
ls.plugin = ls.plugin || {};
ls.plugin.shop = ls.plugin.shop || {};

ls.plugin.shop.fabric =( function ($) {
    /**
     * Предпросмотр топика
     * @param form
     */
    this.updateTypeTitle = function(form) {
        ls.ajax.submit(ls.registry.get('sAdminUrl')+'fabric/ajax/update_type_title/',form,function(oResponse){
        });
	    return false;
    };

	/**
	 * Добавляем ткань
	 */
	this.addFabric = function(form){
		ls.ajax.submit('/'+ADMIN_URL+'/fabric/ajax/add_fabric/',form,function(oResponse){
			if (oResponse.sFabric){
				$('.admin-fabric-list').append(oResponse.sFabric);
			}
			$('#form-add-fabric').trigger('reset');

		});
		return false;
	};

	/**
	 * Удаляем ткань
	 */
	this.deleteFabric = function(sFabricTitle, iFabricId){
		if (confirm('Вы действительно хотите удалить ткань "'+sFabricTitle+'"')){
			ls.ajax.load('/'+ADMIN_URL+'/fabric/ajax/delete_fabric/',{iFabricId: iFabricId},function(oResponse){
				ls.msg.notice(null, oResponse.sMsg);
				$('#fabric-'+iFabricId).animate({opacity:0}, 'fast', function() { $(this).remove(); });
			});
			return false;
		}
	};

    return this;
}).call(ls.plugin.shop.fabric || {},jQuery);