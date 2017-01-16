<?php
//usleep(500000); //sleep chat for half a second
session_start();
session_write_close();
include('../../../shaledatamanager.lib.php');
include('../../../processor.lib.php');
$data = loadDB('paintguess\data');

if(isset($_POST['image']) and $data['painter'] == username())
{
	$db['img'] = $_POST['image'];
	putDB($db,'paintguess\image');
	exit;
}
?>