<?php
//security is important yall
//======================================================
//CLEAN ALL USER INPUT FOR SAFTY AND THE GLORY OF SATAN
//======================================================
function clean($value)
{
	$value = strip_tags($value); 
	return $value;
}
foreach($_GET as $key => $value)
{
	$_GET[$key] = clean($value);
}
foreach($_POST as $key => $value)
{
	$_POST[$key] = clean($value);
}
foreach($_COOKIE as $key => $value)
{
	$_COOKIE[$key] = clean($value);
}
//======================================================
//
session_start();
session_write_close();
include('processor.lib.php');
include('shaledatamanager.lib.php');
//=====================
//testing console    //
//        //         //


//========//=========//

if(isloggedin())
{
	if(isset($_GET['paintguess']))
	{
		require('TPL/paintguess/index.tpl');
	}
	else
	{
		echo '
		<!doctype html>
		<html lang="us">
		<head>
		<meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Bick & Howes</title>
		<link href="jquery-ui.css" rel="stylesheet">
		<link href="main.css" rel="stylesheet">
		<script src="external/jquery/jquery.js"></script>
		<script src="jquery-ui.js"></script>
		';
		include('TPL/home.tpl');
	}
}
else
{
	include('TPL/login.tpl');
}

?>