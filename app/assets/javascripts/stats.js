var idLookupUrl = 'https://itunes.apple.com/lookup?id='

$(document).ready(function(){
	$('[data-track-id]').each(function(index, element) {
		itunesId = element.getAttribute('data-track-id')
	   $.ajax({
	     url: idLookupUrl+itunesId,
	     type: 'GET',
	     dataType: 'jsonp',
	     success: function(response){
	     	itunesObject=response['results'][0]
	      element.innerHTML = '<a target = "_blank" href="'+itunesObject.trackViewUrl+'">'+itunesObject.trackName+'</a> <img class="itunesicon" src="itunes.png">';
	     },
	     failure: function(response){
	       console.log(response);
	       console.log("failure");
	     }
	   });
	});

	// this part is really really freaking buggy, maybe take out
 	$('#playartistagain').on('click', function(event){
 		event.preventDefault();
 		console.log('HELLO TEST');
 		$('#loadingscreen').slideDown(1000);
 		$('.returnedstats').hide();
 		$('.gamequestions').remove();
 		$.ajax({
 		  url: '/quiz/create',
 		  type: 'POST',
 		  data: {id: $('#playartistagain').data().itunesid},
 		  success: function(response){
 		    $('#loadingscreen').slideUp(1000);
 		    quiz = scrubQuestionChoices(response);
 		    initializeGame();
 		    $('#start-game').show();
 		  },
 		   failure: function(response){
 		   $('#loadingscreen').slideUp(1000);
 		    console.log('Fail');
 		  }
 		});
 	})
});
