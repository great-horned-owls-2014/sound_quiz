$(document).ready(function(){
  $('#artist_name').on('railsAutocomplete.select', function(event, data){
    console.log(data);
    var artistId = data.item.id;
    location.href = ('/artists/' + artistId);
  })
});
