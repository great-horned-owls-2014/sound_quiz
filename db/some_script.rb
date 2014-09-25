User.create(email: "Peter")

Artist.create(name: "Shigoom")
Artist.first.tracks << Track.create(name: "Shiggitty")
Artist.first.tracks << Track.create(name: "Shig One")
Artist.first.tracks << Track.create(name: "Shig Two")
Artist.first.tracks << Track.create(name: "Shig Three")

Artist.first.quizzes << Quiz.create(difficulty_level: 1)
Quiz.first.questions << Question.create(track_id: Track.first)
Quiz.first.questions << Question.create(track_id: Track.second)
Quiz.first.questions << Question.create(track_id: Track.third)

Question.first.wrongchoices << Wrongchoice.create(track_id: Track.second)
Question.first.wrongchoices << Wrongchoice.create(track_id: Track.third)
Question.first.wrongchoices << Wrongchoice.create(track_id: Track.fourth)
