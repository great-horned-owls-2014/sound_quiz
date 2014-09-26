$(document).ready(function(){
  $('#artist_name').on('railsAutocomplete.select', function(event, data){
    console.log(data);
    var artist_id = data.item.id;
    location.href = ('/artists/' + artist_id);
    //location.href = 'http://google.com'
  });
})
