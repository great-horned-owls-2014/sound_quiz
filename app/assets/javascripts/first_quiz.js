$(document).ready(function(){

  $('[data-artist-id]').on('click', function(e){
    e.preventDefault();
    var artistId = $(this).attr('data-artist-id');
    $.ajax({
          url: '/artists/' + artistId + '/first_quiz',
          type: 'GET',
          success: function(response){

            quiz = scrubQuestionChoices(response);
            initializeGame();
          },
           failure: function(response){
            console.log('Fail');
          }
        });
  })

})
