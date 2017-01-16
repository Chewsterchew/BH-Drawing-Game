<?php
//GET ACTIONS GO HERE
if(isset($_GET['logout']))
{
	session_start();
	unset($_SESSION['login']);
	session_write_close();
	header('location: ./');
	exit;
}
//


//FUCNTION DOCS AND FUNCS GO HERE




//======================================================
//fixname($uncapname) returns names to proper case
//======================================================
function fixname($name)
{
	foreach(glob('DB/users/*.dat') as $path)
	{
		if(!strcasecmp(basename($path,'.dat'),$name))
		{
			$namef = basename($path,'.dat');
			break;
		}
	}
	return $namef;
}
//======================================================

//======================================================
//Returns true if user is already registered isregistered(username);
//======================================================
function isregistered($username)
{
	if(file_exists('./DB/users/'.$username.'.dat'))
	{
		return true;
	}
	else
	{
		return false;
	}
}
//======================================================

//======================================================
//isloggedin() Retruns true if you are logged in
//======================================================
function isloggedin()
{
	if(isset($_SESSION['login']))
	{
		return true;
	}
	else
	{
		return false;
	}
}
//======================================================

//======================================================
//username() returns current logged in username
//======================================================
function username()
{
	if(isset($_SESSION['login']))
	{
		return $_SESSION['login'];
	}
	else
	{
		return false;
	}
}
//======================================================
















?>