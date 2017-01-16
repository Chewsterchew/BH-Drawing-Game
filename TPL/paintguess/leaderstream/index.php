<?php
SESSION_START();
session_write_close();
include('../../../processor.lib.php');
include('../../../shaledatamanager.lib.php');
//
//Extra Library
function cmp($a, $b) {
    return @$a['score'] < @$b['score'];
}
//


$twodata = loadDB('paintguess\data');

if(isset($twodata['online']))
{
	$a = $twodata['online'];
	uasort($a, 'cmp');
	echo '<center><table><tr><th>Leader Board</th><th>Points</th></tr>';
	foreach($a as $users => $udata)
	{
		if(isset($udata['score']))
		{
			echo '<tr><td><span id="uname2">'.$users.'</span></td><td>'.$udata['score'].'</td></tr>';
		}
		else
		{
			echo '<tr><td><span id="uname2">'.$users.'</span></td><td>0</td></tr>';
		}
	}
	echo '</table></center>';
}
?>