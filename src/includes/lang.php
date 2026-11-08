<?php

function getLanguageMessages($language = NULL) {
	static $catalogs = array();

	if ($language === NULL) {
		$opt = getGlobalOptions();
		$language = $opt["language"];
	}

	$language = is_string($language) ? strtolower($language) : "en";
	if (!in_array($language, array("en", "fr"), true)) {
		$language = "en";
	}

	if (!isset($catalogs[$language])) {
		$messages = array();
		require(dirname(__FILE__) . "/../lang/" . $language . ".inc.php");
		$catalogs[$language] = $messages;
	}

	return $catalogs[$language];
}

function translate($key) {
	$messages = getLanguageMessages();
	return isset($messages[$key]) ? $messages[$key] : $key;
}

function translateFormat($key, ...$args) {
	return vsprintf(translate($key), $args);
}
?>
