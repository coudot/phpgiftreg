<?php

define('SMARTY_DIR', dirname(__FILE__) . "/smarty-3.1.35/libs/");
require_once(SMARTY_DIR . "Smarty.class.php");
require_once(dirname(__FILE__) . "/config.php");
require_once(dirname(__FILE__) . "/lang.php");

class MySmarty extends Smarty {
	public function __construct() {
		parent::__construct();

		$opt = $this->opt();
		$messages = getLanguageMessages($opt["language"]);
		$this->setTemplateDir(dirname(__FILE__) . "/../templates");
		parent::assign('messages', $messages);
		parent::assign('datepicker_json', json_encode($messages["datepicker"], JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP));
		date_default_timezone_set("GMT+0");
	}

	public function dbh() {
		$opt = $this->opt();
		return new PDO(
			$opt["pdo_connection_string"],
			$opt["pdo_username"],
			$opt["pdo_password"]);
	}

	public function opt() {
		static $opt;
		if (!isset($opt)) {
			$opt = getGlobalOptions();
			if (!in_array($opt["language"], array("en", "fr"), true)) {
				$opt["language"] = "en";
			}
			$messages = getLanguageMessages($opt["language"]);
			$opt["date_format"] = $messages["date_format"];
		}
		return $opt;
	}

	public function display($template = NULL, $cache_id = NULL, $compile_id = NULL, $parent = NULL) {
		parent::assign('isadmin', isset($_SESSION['admin']) ? $_SESSION['admin'] : false);
		parent::assign('opt', $this->opt());
		parent::assign('messages', getLanguageMessages($this->opt()["language"]));
		parent::display($template, $cache_id, $compile_id, $parent);
	}
}
?>
