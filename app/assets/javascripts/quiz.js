var testResponse;
var numOfQuestions = 5;
var gameover = false;
var currentQuestion = 0;
var test;
var time = new Date();
var timeArray = [];
var quiz;
var answerArray = [];
var numOfNonQuestions = 3;
var questionTime = 30000;

$(document).ready(function(){

  //start and play the game
  $('button#start').on('click', function(event){
    $('#choices-screen').show();
    recordTimeTaken();
    hideSelf.call(this);
    showNext.call(this);
    playNextTrack.call(this);
    $('#timer').show();
    timer(questionTime, this);
  });
  $('body').on('click', ".answer-button", function(event){
    recordTimeTaken();
    recordUserAnswer.call(this);
    $(this).parent().children('audio')[0].pause();
    hideSelf.call(this);
    showNext.call(this);
    checkGameStatus.call(this);
    timer(questionTime, this);
  });
});

function checkGameStatus(){
  if(timeArray.length === 6){
      $('#loadingscreen').slideDown(1000);
      $('#timer').hide();
      $('#choices-screen').hide();
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
      $('#loadingscreen').slideUp(1000);
      setTimeout(function (){
        $('.container').append(response);
        updateItunesLinks();
      },1000);
    },
    failure: function(response){
      $('#loadingscreen').slideUp(1000);
      console.log(response);
      console.log("Failure!!!");
    }
  });
}

function formatValues(){
  var formattedValues = {'returnVals':{ }, 'artistId': artistId};
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
  document.querySelector('#artist-search').style.display = 'none';
  document.querySelector('#game-section').style.display = 'inherit';
  timeArray = [];
  answerArray = [];
  for(var i=1; i <= (Object.keys(quiz).length - numOfNonQuestions); i++){
    $('#game-section').append(generateQuestionDiv(quiz['question_'+i]));
  }
}

function generateQuestionDiv(question){
  divString = '<div  style="display: none;" class="gamequestions" data-questionId="'+ question['db_id']  +'">';
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
