$(document).ready(function(){
  $('#artist_name').on('railsAutocomplete.select', function(event, data){
    event.preventDefault();
    console.log(data);
    var artist_id = data.item.id;
    location.href = ('/artists/' + artist_id);
    // var artistRoute = '/artists/' + artist_id
    // $(this).append('<a class="artist" href=' + artistRoute + '></a>');
    //location.href = 'http://google.com'
  });
})
