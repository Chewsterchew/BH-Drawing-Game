<?php
	$array = loadDB('paintguess\data'); //Load random data
	$array['online'][username()]['time'] = time();
	putDB($array,'paintguess\data');
	$data = loadDB('paintguess\chatcache');
	array_unshift($data, username().", Has joined the game!");
	putDB($data,'paintguess\chatcache');
	header('location: ./?paintguess');
?>