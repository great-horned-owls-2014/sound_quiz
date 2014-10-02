var idLookupUrl = 'https://itunes.apple.com/lookup?id=';

$(document).ready(function(){

 	$('body').delegate('#playartistagain', 'click', function(event){
 		event.preventDefault();
 		$('#artist-section').hide();
 		$('.practice-quizzes').hide();
 		$('#game-section').show();
 		$('.quiz-results-area').remove();
 		$('.gamequestions').remove();
 		$('button#loading').show();
 		$.ajax({
 		  url: '/quiz/create',
 		  type: 'POST',
 		  data: {id: $(this).data().itunesid},
 		  success: function(response){
 		    quiz = scrubQuestionChoices(response);
 		    $('.ui-autocomplete').remove();
 		    $('.ui-helper-hidden-accessible').remove();
 		    initializeGame();
 		    $('button#loading').hide();
       		$('button#start').show();
 		    $('#start-game').show();
 		  },
 		   failure: function(response){
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

