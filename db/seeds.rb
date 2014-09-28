User.create(email: "Peter")

Artist.create(name: "Shigoom")
Artist.first.tracks << Track.create(name: "Shiggitty")
Artist.first.tracks << Track.create(name: "Shig One")
Artist.first.tracks << Track.create(name: "Shig Two")
Artist.first.tracks << Track.create(name: "Shig Three")
Artist.first.tracks << Track.create(name: "Shig Four")

Artist.first.quizzes << Quiz.create(difficulty_level: 1)
Quiz.first.questions << Question.create(right_answer: Track.first)
Quiz.first.questions << Question.create(right_answer: Track.second)
Quiz.first.questions << Question.create(right_answer: Track.third)
Quiz.first.questions << Question.create(right_answer: Track.fourth)
Quiz.first.questions << Question.create(right_answer: Track.fifth)

Question.first.wrong_choices << WrongChoice.create(track: Track.second)
Question.first.wrong_choices << WrongChoice.create(track: Track.third)
Question.first.wrong_choices << WrongChoice.create(track: Track.fourth)

User.first.user_answers << UserAnswer.create(track_id: 1, question_id: 1, response_time: 0.1 )
User.first.user_answers << UserAnswer.create(track_id: 2, question_id: 2, response_time: 0.1 )
User.first.user_answers << UserAnswer.create(track_id: 3, question_id: 3, response_time: 0.1 )
User.first.user_answers << UserAnswer.create(track_id: 4, question_id: 4, response_time: 0.1 )
User.first.user_answers << UserAnswer.create(track_id: 5, question_id: 4, response_time: 0.1 )

