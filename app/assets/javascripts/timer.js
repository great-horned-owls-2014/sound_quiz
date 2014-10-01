var intervalId;

var timer = function(choiceTime, returnedThis){
  debugger
  clearInterval(intervalId);
  var timerTime = choiceTime;
  $('#timer').text(timerTime/1000);
  intervalId = setInterval(function(){
    timerTime -= 1000;
    if(timerTime <= 0){
      clearInterval(intervalId);
      $(returnedThis).parent().next().find('[data-choiceid="-1"]').trigger('click')
      return
    }
    $('#timer').text(timerTime/1000);

  }, 1000);
}
