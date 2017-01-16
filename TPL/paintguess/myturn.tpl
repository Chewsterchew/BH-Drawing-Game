<body>
  <div id="content">

    <div class="content-box">
      <!-- jQuery UI -->
      <script type="text/javascript" src="./TPL/paintguess/lib/jquery.ui.core.1.10.3.min.js"></script>
      <script type="text/javascript" src="./TPL/paintguess/lib/jquery.ui.widget.1.10.3.min.js"></script>
      <script type="text/javascript" src="./TPL/paintguess/lib/jquery.ui.mouse.1.10.3.min.js"></script>
      <script type="text/javascript" src="./TPL/paintguess/lib/jquery.ui.draggable.1.10.3.min.js"></script>
      
      <!-- wColorPicker -->
      <link rel="Stylesheet" type="text/css" href="./TPL/paintguess/lib/wColorPicker.min.css" />
      <script type="text/javascript" src="./TPL/paintguess/lib/wColorPicker.min.js"></script>

      <!-- wPaint -->
      <link rel="Stylesheet" type="text/css" href="./TPL/paintguess/wPaint.min.css" />
      <script type="text/javascript" src="./TPL/paintguess/wPaint.min.js"></script>
      <script type="text/javascript" src="./TPL/paintguess/plugins/main/wPaint.menu.main.min.js"></script>
      <script type="text/javascript" src="./TPL/paintguess/plugins/shapes/wPaint.menu.main.shapes.min.js"></script>
      <script type="text/javascript" src="./TPL/paintguess/plugins/file/wPaint.menu.main.file.min.js"></script>

	  <div id="guessbox">
	  <div id="stream">
	  </div>
	  </div>
      <div id="wPaint" style="position:absolute; width:700px; height:439px; right:0px; top:0px; background-color:#7a7a7a;"></div>
	  <div id="spacer">
	  <center style="color:white;"><h1>#revivebick&howes</h1>
	  
	  <a href="./?paintguess">View word</a><br><br>
	  <a href="./">Skip Word</a><br><br>
	  <a href="./">Leave Game</a>
	  
	  </center>
	  </div>
	  <div id="leader">
	  <div id="stream2">
	  Loading...
	  </div>
	  </div>

		<script type="text/javascript">
        function saveImg(image) {
          $.ajax({
            type: 'POST',
            url: './TPL/paintguess/upstream/',
            data: {image: image}
          });
        }
		
		

		$.extend($.fn.wPaint.defaults, {
		  mode:        'pencil', 
		  lineWidth:   '3', 
		  fillStyle:   '#FFFFFF',
		  strokeStyle: '#000000'  
		});
        $('#wPaint').wPaint({
          menuOffsetLeft: -42,
          menuOffsetTop: 1,
          saveImg: saveImg,
		  path: './',
		  menuOrientation: 'vertical',
		  bg: '#FFFFFF',
        });
		
		
		function upstream() {
		var image = $("#wPaint").wPaint("image");
		$.ajax({
		type: 'POST',
		url: './TPL/paintguess/upstream/',
		data: {image: image}
		});
		};
		setInterval(upstream, 200);
		
		</script>
		<script>
		$(function() {
		$( "#word" ).dialog({
		  resizable: false,
		  height:140,
		  modal: true,
			hide: {
				effect: 'fade',
				duration: 300
			},
		});
		
		$( "#word" ).parent().effect( "bounce", 1000);
		});
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
		function datastream() {
		  $.ajax({
			url: './TPL/paintguess/datastream/',
			success: function(data) {
			  //$('#wPaint').html(data);
			  $('#stream').html(data);
			}
		  });
		};
		datastream();
		setInterval(datastream, 500);
		</script>
  <div id="word" title="Your Turn!">
  <br>
  <center>Your word is "<?php echo $array['word']; ?>".</center>
  </div>
    </div>
  </div>
</body>
</html>