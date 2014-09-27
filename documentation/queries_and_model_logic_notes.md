## When To Grab A Existing Quiz vs. Quiz Generation

if user.logged_in

  searched_artist == bryan adams


  if exisiting quiz on bryan adams,
       grab & show quiz on bryan adams.

  else

    generate new quiz on bryan adams.


if user.not_logged_in

  searched_artist == bryan adams

  randomly generate quiz


## How Is Quiz Generated?

When you search an artist, max song objects = 50. 50 is the iTunes limit.

Each quiz has 5 questions.

For the default quiz, we generate the easiest quiz (aka Quiz level 1).

For Quiz L1, we choose the 5 most popular song objects. Popularity means total # of sales in comparison to the other 49 results.

PreviewUrl is located at response.results[0].previewUrl.



## How Is A Question Generated?



Model creates a question artistId, artistName, trackId, trackName,

Grab 4 choices where 1 is the right_answer.


