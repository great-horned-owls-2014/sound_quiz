// https://itunes.apple.com/search?attribute=allArtistTerm&term=massive+attack
var songSearchUrl = 'https://itunes.apple.com/search?attribute=allArtistTerm&entity=song&term='
var artistSearchUrl= 'https://itunes.apple.com/search?entity=musicArtist&term='
var testResponse;
var artistName;
var artistId;
var songList = [];
var numOfQuestions = 5;
var gameover = false;
var currentQuestion = 0;
var test;
var time = new Date();
var timeArray = [];

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

  $('button#start').on('click', function(event){
    timeArray.push((new Date()).getTime());
    $('audio#player'+currentQuestion)[0].play()
    $('#songlist').on('click','.answer',function(event){
      timeArray.push((new Date()).getTime());
      $('audio#player'+currentQuestion)[0].pause()
      currentQuestion++
      if(currentQuestion >= numOfQuestions){
        alert('GameOver')
      }
      $('audio#player'+currentQuestion)[0].play()
    })
  })

});

function addTrack(songUrl, questionNum){
  embedString = '<audio controls preload="auto" id="player'+questionNum+'" style="display:none;"><source src="'+songUrl+'" type="audio/mp4"></audio><button name="button'+questionNum+'" class="answer">Answer</button>'
  return embedString;
}

