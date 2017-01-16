<?php
//usleep(500000); //sleep chat for half a second
SESSION_START();
session_write_close();
include('../../../processor.lib.php');
include('../../../shaledatamanager.lib.php');

//DEPENDENCIES

//if 5 seconds pass after last guess chouse another painter
$twodata = loadDB('paintguess\data');
if(isset($twodata['gtime']) and $twodata['gtime'] < (time() - 5))
{
	newPainter();
}
//
//If painter has left the game new painter

if(!isset($twodata['painter']))
{
	$twodata['painter'] = null;
}
if(!isset($twodata['online'][$twodata['painter']]))
{
	newPainter();
}

//
//

//function to change the painter
//function to change the painter
function newPainter()
{
	global $twodata;
	$twodata = loadDB('paintguess\data');
	//Assemble the data, then set the user
	$words = loadDB('paintguess\words'); //Load in the dictionary
	$word = $words[array_rand($words)];
	//
	//Chouse painter
	if(is_array($twodata['online']) )
	{
		$painter = array_rand($twodata['online']);
		while(isset($twodata['painter']) and $painter == $twodata['painter']) //if painter was it last try agian
		{
			$painter = array_rand($twodata['online']);
		}
	}
	else
	{
		$painter = null;
	}
	//
	//Old painter
	if(isset($twodata['painter']))
	{
		$oldpainter = $twodata['painter'];
	}
	else
	{
		$oldpainter = null;
	}
	//
	unset($twodata['guessed']);
	unset($twodata['gtime']);
	$oldword = $twodata['word'];
	$twodata['word'] = $word;
	$twodata['painter'] = $painter;
	$twodata['refresh'] = array($painter,$oldpainter);
	
	putDB($twodata,'paintguess\data');
	$temp = array("<span style='color:lime;'>".$painter." is drawing the word!</span>","<span style='color:orange;'>The last word was, ".$oldword."!</span>");
	putDB($temp,'paintguess\chatcache');
	//exit; //Exit the entire program to keep the system from going corupto
}
//
if(isset($twodata['online'][username()]) and $twodata['online'][username()]['time'] > time() - 3)
{
	if(isset($twodata['refresh']) and in_array(username(),$twodata['refresh']))
	{
		echo '
		<script type="text/javascript">
		window.top.location = \'./?paintguess\';
		</script>';
		foreach($twodata['refresh'] as $key => $val)
		{
			if($val == username())
			{
				unset($twodata['refresh'][$key]);
				break;
			}
		}
		putDB($twodata,'paintguess\data');
		//sleep(1); //wait before next time
		exit;
	}

	$data = loadDB('paintguess\chatcache');
	
	foreach(array_reverse(array_slice($data, 0, 23, true)) as $item)
	{
		echo $item.'<br>';
	}
	
	//Update users online history
	$twodata['online'][username()]['time'] = time();
	//
	//scan the db for peeps who aint online
	foreach($twodata['online'] as $username => $usersonline)
	{
		if($usersonline['time'] < time() - 3)
		{
			unset($twodata['online'][$username]);
			array_unshift($data, $username.", Has left the game...");
			putDB($data,'paintguess\chatcache');
		}
	}
	//
	
	
	putDB($twodata,'paintguess\data');
}
else
{
		echo '<center><h1 style="color:white;">Error sessions deleted...</h1></center>
		<script type="text/javascript">
		window.top.location = \'./?paintguess\';
		</script>';
}

?>