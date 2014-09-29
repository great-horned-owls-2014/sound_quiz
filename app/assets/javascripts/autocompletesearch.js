$(document).ready(function(){

  //prevent pressing of enter and making a manual call to iTunes API
  $(window).keydown(function(event){
     if(event.keyCode == 13) {
       event.preventDefault();
       return false;
     }
   });

  //invariants
  var songSearchUrl = 'https://itunes.apple.com/search?attribute=allArtistTerm&entity=song&limit=100&term=';
  var artistSearchUrl= 'https://itunes.apple.com/search?entity=musicArtist&limit=5&term=';

  //results from iTunes APIs
  var artistName = '';
  var artistId;
  var artistObjectResults = null;

  function createSongList(artistObjectResults){
    songArray = [];
    for(var i =0; i< artistObjectResults['results'].length; i++){
      if (artistId === artistObjectResults['results'][i].artistId) {
        songArray.push(createSongObject( artistObjectResults['results'][i] ));
      }
    }
    return songArray;
  }

  function createSongObject(itunesObject){
    filteredObject = { 'artworkUrl100': itunesObject.artworkUrl100,
                        'previewUrl': itunesObject.previewUrl,
                        'trackName': itunesObject.trackName,
                        'trackdId': itunesObject.trackId
                      };

    return filteredObject;
  }

  function dbSend(artistName, artistId, songArray){
    $.ajax({
      url: '/quiz/create',
      type: 'POST',
      data: {name: artistName, id: artistId, list: songArray},
      success: function(response){

        quiz = scrubQuestionChoices(response);
        initializeGame();
      },
       failure: function(response){
        console.log('Fail');
      }
    });
  }

  function scrubQuestionChoices(quiz){
    for(var i=1; i <= (Object.keys(quiz).length - numOfNonQuestions); i++){
      for ( var j=0; j < quiz['question_'+i]['choices'].length; j++){
        delete (quiz['question_'+i]['choices'][j].preview_url);
        delete (quiz['question_'+i]['choices'][j].created_at);
        delete (quiz['question_'+i]['choices'][j].updated_at);
      }
    }
    return quiz;
  }


  $('#artistsearchterm').autocomplete({
    // minLength: 3,
    delay: 500,
      // calling autocomplete creates a request object containing the terms you input into the selector.
      // not sure what the response argument is
    source: function(request, response) {
        var artistSearchTerms = $('#artistsearchterm').val();
        $.ajax({
            url: artistSearchUrl + artistSearchTerms,
            dataType: "jsonp",
            data: {term: request.term},
            success: function( artistObject ) {
              console.log(artistObject)
              artistObjectResults = artistObject.results
              response($.map( artistObjectResults, function( item ) {

              artistLabel = item.artistName + "     / GENRE: " + item.primaryGenreName;
              //var artistLabel = item.artistName + "     / GENRE: " + item.primaryGenreName;
              return {
                label: artistLabel,
                artistId: item.artistId,
                artistName: item.artistName
              }
              }));
              document.querySelector("#ui-id-1").removeAttribute("style");
            },
            failure: function( data ) {
              console.log ('Ajax fail');
              response ( data );
            }
        });
      },

    select: function(event, ui){
      event.preventDefault();
      artistId = ui.item.artistId;
      artistName = ui.item.artistName;
      $.ajax({
        url: songSearchUrl + artistName,
        type: 'GET',
        dataType: 'jsonp'
      })
      .done(function(songObject){
        selectedArtistSongList = createSongList(songObject);
        dbSend(artistName, artistId, selectedArtistSongList);
      })
      .fail(function(failResponse){
        console.log("Ajax failed. Here was the response from the server: " + failResponse);
      })
    }

  });
})
