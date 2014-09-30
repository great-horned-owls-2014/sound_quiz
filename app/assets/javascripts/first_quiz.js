$(document).ready(function(){

  $('[data-artist-id]').on('click', function(e){
    e.preventDefault();
    alert("I'm here!");
    var artistId = $(this).attr('data-artist-id');
    console.log(artistId);
    $.ajax({
          url: '/artists/' + artistId + '/first_quiz',
          type: 'GET',
          success: function(response){
            $('.artist-leaderboard').hide();
            alert('Success! Something else wrong?');
            quiz = scrubQuestionChoices(response);
            initializeGame();
          },
           failure: function(response){
            console.log('Fail');
          }
        });
  })

})
