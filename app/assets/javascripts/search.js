// https://itunes.apple.com/search?attribute=allArtistTerm&term=massive+attack
var songSearchUrl = 'https://itunes.apple.com/search?attribute=allArtistTerm&entity=song&limit=100&term=';
var artistSearchUrl= 'https://itunes.apple.com/search?entity=musicArtist&limit=5&term=';
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
var quiz;
var answerArray = [];
var numOfNonQuestions = 3;

$(document).ready(function(){
  $('#searchbar').on('submit', function(event){
    event.preventDefault();
    searchTerm = $('#searchterm').val();

    $.ajax({
      url: artistSearchUrl+searchTerm,
      type: 'GET',
      dataType: 'jsonp',
      success: function(response){
        appendArtists(response);
      },
      failure: function(response){
        console.log('Fail');
      }
    });
  });

  function appendArtists(artistObject){
    for(var i=0; i<artistObject['results'].length; i++){
      $('#artist-list ul').append( createArtistListEntry(artistObject['results'][i] ));
    }
  }

  function createArtistListEntry(artistObj){
    return '<li><a href="'+ artistObj.artistLinkUrl +'" data-artistid="'+artistObj.artistId+'">'+artistObj.artistName +'</a></li>';
  }

  $('#artist-list').on('click', 'a', function(event){

    event.preventDefault();
    artistId = $(this).data('artistid');
    artistName = $(this).text();

    $.ajax({
      url: songSearchUrl + artistName,
      type: 'GET',
      dataType: 'jsonp',
      success: function(response){
        songList = createSongList(response);
        dbSend(artistName, artistId, songList);
      },
       failure: function(response){
        console.log('Fail');
      }
    });
  });

  function createSongList(artistObject){
    songArray = [];
    for(var i =0; i< artistObject['results'].length; i++){
      if (artistId === artistObject['results'][i].artistId) {
        songArray.push(createSongObject( artistObject['results'][i] ));
      }
    }
    return songArray;
  }

  function createSongObject(itunesObject){
    filteredObject = { 'artworkUrl100': itunesObject.artworkUrl100,
                        'previewUrl': itunesObject.previewUrl,
                        'trackName': itunesObject.trackName};
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

  //start and play the game
  $('button#start').on('click', function(event){
    recordTimeTaken();
    hideSelf.call(this);
    showNext.call(this);
    playNextTrack.call(this);
  });

  $('body').on('click', ".answer-button", function(event){
    recordTimeTaken();
    recordUserAnswer.call(this);
    $(this).parent().children('audio')[0].pause();
    hideSelf.call(this);
    showNext.call(this);
    checkGameStatus.call(this);
  });
});

function checkGameStatus(){
  if(timeArray.length === 6){
      endGame();
    }
    else{
      playNextTrack.call(this);
    }
}

function endGame(){
  $('#stats').show();
  $.ajax({
    url: '/quiz/stats',
    type: 'POST',
    data: formatValues(),
    success: function(response){
      $('#score').append('<h1>'+response+'</h1>');
    },
    failure: function(response){
      console.log(response);
      console.log("failure");
    }
  });
}

function formatValues(){
  var formattedValues = {'returnVals':{ }};
  for(var i=0; i < answerArray.length; i++){
    formattedValues['returnVals'][i] = { track_id: answerArray[i].choiceid, question: answerArray[i].questionid, response_time: (timeArray[i+1] - timeArray[i]) };
  }
  return formattedValues;
}

function playNextTrack(){
    $(this).parent().next().children('audio')[0].play();
}

function hideSelf(){
  $(this).parent().hide();
}

function showNext(){
  $(this).parent().next().show();
}

function recordTimeTaken(){
  timeArray.push((new Date()).getTime());
}

function recordUserAnswer(){
  answerArray.push($(this).data());
}

function initializeGame(){
  document.querySelector('#artist-section').style.display = 'none';
  document.querySelector('#game-section').style.display = 'inherit';
  for(var i=1; i <= (Object.keys(quiz).length - numOfNonQuestions); i++){
    $('#game-section').append(generateQuestionDiv(quiz['question_'+i]));
  }
}

function generateQuestionDiv(question){
  divString = '<div  style="display: none;" data-questionId="'+ question['db_id']  +'">';
  for(var i=0; i< question.choices.length; i++){
    divString += '<button style="display:block;" data-questionId="' + question['db_id'] + '" data-choiceId="'+ question.choices[i].id +'" class="answer-button" type="button">'+question.choices[i].name+'</button>';
  }
  divString += songPlayer(question.player_url)+'</div>';
  return divString;
}

function appendSongs(songArray){
  for(var i = 0; i < numOfQuestions; i++){
    $('#songlist').append('<li id="question'+i+'">' + songArray[i].trackName + songPlayer(songArray[i].previewUrl, i)+' </li>');
  }
}

function songPlayer(songUrl){
  embedString = '<audio controls preload="auto" style="display:none;"><source src="'+songUrl+'" type="audio/mp4"></audio>';
  return embedString;
}


