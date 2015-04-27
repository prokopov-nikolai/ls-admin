<?php

class PluginAdmin_ActionAdmin extends PluginAdmin_ActionPlugin {

    public function Init() {
	    parent::Init();
	    $this->SetDefaultEvent('index');
    }

    /**
     * Регистрируем евенты
     *
     */
    protected function RegisterEvent() {
	    $this->AddEventPreg('/^cache_delete$/i','CacheDelete');

	    $this->AddEvent('error','Error');
	    $this->AddEvent('index','Index');
    }

	/**
	 * Страница приветсвия
	 */
	public function Index(){
		$this->AppendBreadCrumb(10, $this->Lang_Get('plugin.admin.breadcrumbs.start'));

		$this->SetTemplateAction('index');
	}

	/**
	 * Сбрасываем кеш
	 */
	public function CacheDelete() {
		$this->Cache_Clean(Zend_Cache::CLEANING_MODE_ALL);
		/**
		 * Сбрасываем кеш файлов
		 */
		$sCacheDir=Config::Get('path.cache_assets.server')."/".Config::Get('view.skin');
		if (file_exists($sCacheDir)) {
			$oDir = dir($sCacheDir);
			while (false !== ($sFilePath = $oDir->read())) {
				if(preg_match('/\.(js|css)$/', $sFilePath)){
					unlink($sCacheDir.'/'.$sFilePath);
				}
			}
			$oDir->close();
		}
		/**
		 * TODO: вынести в языковик
		 */
		$this->Message_AddNotice('Кеш успешно сброшен', 'Внимание', true);
		Router::Location($_SERVER['HTTP_REFERER']);
    }

	public function Error(){
		if (!LS::Adm()) {
			return Router::Action('error', Router::GetParam(0));
		} else {

		}
	}
}