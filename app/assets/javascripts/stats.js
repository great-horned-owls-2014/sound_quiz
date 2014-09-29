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
	      element.innerHTML = '<a href="'+itunesObject.trackViewUrl+'">'+itunesObject.trackName+'</a>';
	     },
	     failure: function(response){
	       console.log(response);
	       console.log("failure");
	     }
	   });
	});
});