<?php

if(isset($_POST['guess']) and !empty($_POST['guess']) and strtolower($_POST['guess']) !== strtolower($array['word'])) //Push to array and clean it up as well =)
{
	$data = loadDB('paintguess\chatcache');
	array_unshift($data, '<span id="uname">'.username()."</span> - ".$_POST['guess']);
	putDB($data,'paintguess\chatcache');
}
elseif(isset($_POST['guess']) and strtolower($_POST['guess']) == strtolower($array['word']))
{
	$array = loadDB('paintguess\data'); //Load random data
	$data = loadDB('paintguess\chatcache');
	if(!isset($array['guessed']))
	{
		$array['guessed'] = array();
	}
	if(!in_array(username(),$array['guessed']))
	{
		array_unshift($data, '<span style="color:red;">'.username()." has guessed the word! 5 more seconds on the clock!</span>");
		array_unshift($array['guessed'], username());
		if(isset($array['online'][username()]['score']))
		{
			$array['online'][username()]['score'] = $array['online'][username()]['score'] + 2;
			
		}
		else
		{
			$array['online'][username()]['score'] = 2;
		}
		if($array['online'][$array['painter']]['score'])
		{
			$array['online'][$array['painter']]['score'] = $array['online'][$array['painter']]['score'] + 1;
		}
		else
		{
			$array['online'][$array['painter']]['score'] = 1;
		}
		$array['gtime'] = time();
		putDB($array,'paintguess\data');
	}
	putDB($data,'paintguess\chatcache');
}

?>
<body>
  <div id="content">
    <div class="content-box">
      <link rel="Stylesheet" type="text/css" href="./TPL/paintguess/wPaint.min.css" />

	  <div id="guessbox">
		<div id="stream">
		<center>Loading...</center>
		</div>
	  
	  <form action="#" id="guesstype">
		<input autocomplete="off" style="width:100%;" type="text" name="guess"/>
	  </form>
	  </div>
      <div id="wPaint" style="position:absolute; width:700px; height:439px; right:0px; top:0px; background-color:white;"></div>
	  <div id="spacer">
	  <center style="color:white;"><h1>#revivebick&howes</h1>
	  
	  <a href="./">Leave Game</a>
	  
	  </center>

	  </div>
	  <div id="leader">
	  <div id="stream2">
	  Loading...
	  </div>
	  </div>
</body>
<script><!-- paintguesspicturestream -->
function picstream() {
$.ajax({
    url: './TPL/paintguess/picstream/',
    success: function(data) {
	  $('#wPaint').html(data);
    }
});
};
setInterval(picstream, 300);
</script>
<script>
function datastream() {
$.ajax({
    url: './TPL/paintguess/datastream/',
    success: function(data) {
      //$('#wPaint').html(data);
	  $('#stream').html(data);
    }
}).done(function()
{
	$("#stream").animate({ scrollTop: $("#stream")[0].scrollHeight}, 1000);
});
};
datastream();
setInterval(datastream, 500);
</script>
<script>
function datastream2() {
  $.ajax({
    url: './TPL/paintguess/leaderstream/',
    success: function(data) {
      //$('#wPaint').html(data);
	  $('#stream2').html(data);
    }
  }).done(function()
  {
	$("#stream2").animate({ scrollTop: $("#stream2")[0].scrollHeight}, 1000);
  });
};
datastream2();
setInterval(datastream2, 2000);
</script>
<script>
$("#guesstype").submit(function(event) {

    event.preventDefault();

    var values = $(this).serialize();

    $.ajax({
        url: "./?paintguess",
        type: "post",
        data: values,
		success: function(){
			var subm = $("#guesstype").closest('form').find("input[type=text], textarea").val();
			$( "#stream" ).append( "<?php echo username(); ?> - " + subm + "<br>" );
            $("#guesstype").closest('form').find("input[type=text], textarea").val("");
        },
    });
	
});
</script>