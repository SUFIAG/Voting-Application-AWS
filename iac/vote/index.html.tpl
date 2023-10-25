<!DOCTYPE html>
<html>
  <head profile="//www.w3.org/2005/10/profile">
<link rel="icon" 
      type="image/png" 
      href="//example.com/myicon.png">
    <meta charset="utf-8">
    <title>A or B?</title>
    <base href="/index.html">
    <meta name = "viewport" content = "width=device-width, initial-scale = 1.0">
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  </head>
  <body>
    <div id="content-container">
      <div id="content-container-center">
        <form id="choice" name='form' method="POST" action="//5y7dfynd34.execute-api.us-east-1.amazonaws.com/voting">
        <h3>A or B?</h3>
          <button id="a" type="submit" name="vote" class="a" value="a">A</button>
          <button id="b" type="submit" name="vote" class="b" value="b">B</button>
        </form>
        <div id="tip">
          (you can vote many times)
        </div>
      </div>
    </div>
	
    <script src="//code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
  	<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
   

    <script>
	
      var backend_url = "${backend_api_gateway}"+ "voting"
      console.log('-----------------backend url--------------------')
      console.log(backend_url)



      $.ajaxSetup({
          headers: {
              'Content-Type': 'text/plain',
              'Accept': 'application/json'
          }
      });


      $(document).on('click','button[name=vote]',function(){
        vote = this.value;
		console.log("vote - this.value is var below!") ;
		console.log(vote);
		
		
		data = {"MessageAttributes": {"vote": {"Type": "String","StringValue": vote},
		"voter": {"Type": "String","StringValue": "count"}}}
		
		
		console.log(JSON.stringify(data))
		console.log('-----------------end of json stringify------------------------')
		
		
		$.post(backend_url, JSON.stringify(data), function(result,status){
		console.log('----------------')
		console.log('result presented here')
        console.log(result);
        if ("success" == status) {
			console.log("status good");
            usedButton = $('button.' + vote);
            usedButton.prop('disabled', true);
            usedButton.html(vote + ' <i class="fa fa-check-circle"></i>');
            usedButton.css('opacity','0.5');
            unusedButton = $('button.' + (vote == 'a' ? 'b' : 'a'));
            unusedButton.prop('disabled', false);
            unusedButton.html(vote == 'a' ? 'b' : 'a');
            unusedButton.css('opacity','1');
            setTimeout(function(){usedButton.prop('disabled', false); usedButton.html(vote);}, 2000);
          } else {
		  	console.log("status bad");

            alert("error ! :(");
          }
        });
        return false;
      });
	  
	 
	  
    </script>
  </body>
</html>

  
  