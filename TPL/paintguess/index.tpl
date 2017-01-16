<?php
$array = loadDB('paintguess\data'); //Load random data
if(isset($array['online'][username()]) and $array['online'][username()]['time'] > time() - 10)
{
		echo '
	<!doctype html>
	<html lang="us">
	<head>
	<meta charset="utf-8">
	<title>Bick & Howes - PaintGuess</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link href="jquery-ui.css" rel="stylesheet">
	<link href="main.css" rel="stylesheet">
	<script src="external/jquery/jquery.js"></script>
	<script src="jquery-ui.js"></script>
	';
	function myturn()
	{
		global $array;
		if(isset($array['painter']) and $array['painter'] == username())
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	if(myturn() == true)
	{
		require('myturn.tpl');
	}
	else
	{
		require('guess.tpl');
	}
}
else
{
	include('join.tpl');
}
?>