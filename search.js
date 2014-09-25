// https://itunes.apple.com/search?attribute=allArtistTerm&term=massive+attack
var songSearchUrl = 'https://itunes.apple.com/search?attribute=allArtistTerm&entity=song&term='
var artistSearchUrl= 'https://itunes.apple.com/search?entity=musicArtist&term='
var testResponse;
var artistName;
var artistId;
var songList = [];
var numOfQuestions = 5;

var test;

$(document).ready(function(){
  $('form').submit(function(event){
    event.preventDefault();
    searchTerm = $('#searchterm').val();
    $.ajax({
      url: artistSearchUrl+searchTerm,
      type: 'GET',
      dataType: 'jsonp',
      success: function(response){
        testResponse = response;
        for(var i=0; i<response['results'].length; i++){
          $('#artistlist ul').append('<li><a href="'+ response['results'][i].artistLinkUrl +'" data-artistid="'+response['results'][i].artistId+'">'+response['results'][i].artistName + '</a></li>');
        }
      },
      failure: function(response){
        console.log('Fail');
      }
    })
  })

  $('#artistlist').on('click', 'a', function(event){
    event.preventDefault();
    artistId = $(this).data('artistid');
    artistName = $(this).text();
    console.log(songSearchUrl + artistName);
    $.ajax({
      url: songSearchUrl + artistName,
      type: 'GET',
      dataType: 'jsonp',
      success: function(response){
        console.log(response);
        test = response;
        for(var i =0; i< response['results'].length; i++){
          if (artistId === response['results'][i].artistId) {
            songList.push(response['results'][i]);
          }
        }
        $('#artistsection').hide()
        $('#songsection').show()
        for(var i = 0; i < numOfQuestions; i++){
          $('#songlist').append('<li id="question'+i+'">' + songList[i].trackName + addTrack(songList[i].previewUrl, i)+' </li>')
        }
      },
       failure: function(response){
        console.log('Fail');
      }
    });
  });

  // Adding the songs to the song list
  if(songList.length > 0){

  }
});

function addTrack(songUrl){
  embedString = '<audio controls preload="auto"><source src="'+songUrl+'" type="audio/mp4"></audio>'
  return embedString;
}


