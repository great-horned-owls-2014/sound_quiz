$(document).ready(function(){

  var artistId = '';

  $('#artistsearchterm').autocomplete({
    // minLength: 3,
    delay: 500,
      // calling autocomplete creates a request object containing the terms you input into the selector.
      // not sure what the response argument is
    source: function(request, response) {
        
        // console.log("Here is the source response: ")
        // console.log(response);
        var artistSearchTerms = $('#artistsearchterm').val();
        $.ajax({
            url: "https://itunes.apple.com/search?entity=musicArtist&limit=5&term=" + artistSearchTerms,
            dataType: "jsonp",
            data: {term: request.term},
            success: function( data ) {
              response($.map( data.results, function( item ) {
                artistId = item.artistId
                var artistLabel = item.artistName + "     / GENRE: " + item.primaryGenreName
                return {
                    label: artistLabel,
                    // value: item.artistId,
                }
              }));
            },
            failure: function( data ) {
              console.log ('Ajax fail');
              response ( data );
            }
        });
      },
    select: function(event, ui){
      event.preventDefault();
      $.ajax({
        url: "/artists/",
        datatype: 'json'
      }).done(function(response){
        console.log("Success! It worked! You sent the artistId: " + artistId)
      }).fail(function(failResponse){
        console.log("Ajax failed. Here was the response from the server: " + failResponse);
      })
    }
  });

})
