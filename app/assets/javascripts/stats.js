var idLookupUrl = 'https://itunes.apple.com/lookup?id='

$(document).ready(function(){

	// this part is really really freaking buggy, maybe take out
 	$('body').delegate('#playartistagain', 'click', function(event){
 		event.preventDefault();
 		$('#artist-section').hide();
 		$('.practice-quizzes').hide();
 		$('#loadingscreen').slideDown(1000);
 		$('.returnedstats').hide();
 		$('.gamequestions').remove();
 		$.ajax({
 		  url: '/quiz/create',
 		  type: 'POST',
 		  data: {id: $(this).data().itunesid},
 		  success: function(response){
 		    $('#loadingscreen').slideUp(1000);
 		    quiz = scrubQuestionChoices(response);
 		    $('.ui-autocomplete').remove();
 		    $('.ui-helper-hidden-accessible').remove();
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

function updateItunesLinks(){
	$('[data-track-id]').each(function(index, element) {
		itunesId = element.getAttribute('data-track-id')
	   $.ajax({
	     url: idLookupUrl+itunesId,
	     type: 'GET',
	     dataType: 'jsonp',
	     success: function(response){
	     	itunesObject=response['results'][0]
	      element.innerHTML = '<a target = "_blank" href="'+itunesObject.trackViewUrl+'">'+itunesObject.trackName+'</a> ';
	     },
	     failure: function(response){
	       console.log(response);
	       console.log("failure");
	     }
	   });
	});
}

