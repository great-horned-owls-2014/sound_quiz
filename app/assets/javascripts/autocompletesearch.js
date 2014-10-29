
function placeAutocomplete(){
    var inputWidth = $('#artistsearchterm').width();
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
      $('button#loading').hide();
      $('button#play').show();
      quiz = scrubQuestionChoices(response);
      initializeGame();
    },
     error: function(response){
     errorHandling('iTunes does not have enough songs to generate quiz.')
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

function errorHandling(message){
  $('.container').hide();
  $('.errors').append('<p>Error: '+message+'</p><br>')
  $('.errors').append('<p><a href="/">Please try again.</a></p>')
  $('.errors').show();
}

function clearNonPlayArea(){
  $('#artist-section').hide();
  $('.practice-quizzes').hide();
  $('.quiz-results-area').remove();
  $('.gamequestions').remove();
  $('#game-section').show();
  $('button#loading').show();
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
            timeout: 3000,
            data: {term: request.term},
            success: function( artistObject ) {
              artistObjectResults = artistObject.results
              response($.map( artistObjectResults, function( item ) {

              artistLabel = item.artistName + "     / GENRE: " + item.primaryGenreName;

              return {
                label: artistLabel,
                artistId: item.artistId,
                artistName: item.artistName
              }
              }));
              document.querySelector("#ui-id-1").removeAttribute("style");
            },
            error: function(request, status, err) {
               if(status==="timeout") {
                  errorHandling('iTunes seems to be unresponsive');
               } else {
                  errorHandling(status);
               }
            }
        });
      },

    select: function(event, ui){
      event.preventDefault();
      artistId = ui.item.artistId;
      artistName = ui.item.artistName;
      
      clearNonPlayArea();

      $.ajax({
        url: songSearchUrl + artistName,
        type: 'GET',
        dataType: 'jsonp',
        success: function(songObject){
          selectedArtistSongList = createSongList(songObject);
          dbSend(artistName, artistId, selectedArtistSongList);
        },
        error: function(request, status, err){
          $('button#loading').hide();
          errorHandling(status);
        }
      })
    },
  });
})


