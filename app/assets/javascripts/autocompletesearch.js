  //prevent pressing of enter and making a manual call to iTunes API
  $(window).keydown(function(event){
     if(event.keyCode == 13) {
       event.preventDefault();
       return false;
     }
   });

  function placeAutocomplete(){
      var inputWidth = $('#artistsearchterm').width();
      console.log(inputWidth)
     $('#ui-id-1').css("margin-left",  (-1 * inputWidth / 2 - 6) +"px" );
  }

  //invariants
  var songSearchUrl = 'https://itunes.apple.com/search?attribute=allArtistTerm&entity=song&limit=100&term=';
  var artistSearchUrl= 'https://itunes.apple.com/search?entity=musicArtist&limit=5&term=';
  var menuUL = $('.ui-menu');

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
                        'trackId': itunesObject.trackId
                      };

    return filteredObject;
  }

  function dbSend(artistName, artistId, songArray){
    $.ajax({
      url: '/quiz/create',
      type: 'POST',
      data: {name: artistName, id: artistId, list: songArray},
      success: function(response){
        $('#loadingscreen').slideUp(1000);
        quiz = scrubQuestionChoices(response);
        initializeGame();
      },
       error: function(response){
       $('#loadingscreen').slideUp(1000);
       $('.errors').append("<p>iTunes does not have enough songs to generate quiz.</p><br>")
       $('.errors').append('<p><a href="/">Please pick another artist</a></p>')
       $('.errors').show();
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



$(document).ready(function(){

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
      $('#artist-section').hide();
      $('.practice-quizzes').hide();
      $('#loadingscreen').slideDown(1000);

      $.ajax({
        url: songSearchUrl + artistName,
        type: 'GET',
        dataType: 'jsonp',
        success: function(songObject){
          selectedArtistSongList = createSongList(songObject);
          dbSend(artistName, artistId, selectedArtistSongList);
        },
        failure: function(failResponse){
          $('#loadingscreen').slideUp();
          console.log("Ajax failed. Here was the response from the server: " + failResponse);
        }
      })
    },
  });
})


