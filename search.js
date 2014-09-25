// https://itunes.apple.com/search?term=massive+attack&attribute=allArtistTerm
searchUrl= 'https://itunes.apple.com/search?entity=musicArtist&term='
var testResponse;

$(document).ready(function(){
  $('form').submit(function(event){
    event.preventDefault();
    searchTerm = $('#searchterm').val();
      $.ajax({
        url: searchUrl+searchTerm,
        type: 'GET',
        dataType: 'jsonp',
        success: function(response){
          testResponse = response;
          for(var i=0; i<response['results'].length; i++){
            $('#artistlist ul').append('<li><a href="'+ response['results'][i].artistLinkUrl +'">'+response['results'][i].artistName + '</a></li>');
          }
        },
        failure: function(response){
          console.log('Fail');
        }
      })
  })
});
