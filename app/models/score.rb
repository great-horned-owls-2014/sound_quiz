# slide 1

# we knew about the commutativeness of the ARCADE-Y-NESS

CORRECTNESS_VALUE = 1.0
# total seconds in sound clips
MAX_GUESS_TIME = 30.0

def score_answer player_answer, guess_time, correct_answer
  return 0 unless player_answer == correct_answer
  time_bonus =
    # covert guess time to value between 0 and 1
    (MAX_GUESS_TIME - guess_time) / MAX_GUESS_TIME
  CORRECTNESS_VALUE + time_bonus
end

# slide 2

# arcadiness
ARCADE_FACTOR = 100000
# rewards for difficulty
DLEVEL_MULTIPLIERS = { 1 => 1, 2 => 1.5, 3 => 2.5 }

# first arg is array of pairs
def score_quiz player_answers_and_times, correct_answers, difficulty_level
  quiz_score =
    # 1. compose array of triples like: [player_answer, time, correct_answer]
    player_answers_and_times.zip(correct_answers).map(&:flatten).
    # 2. invoke score_answer with those args and collect the scores
    map { |triple| score_answer *triple }.
    # 3. sum them up
    reduce(:+)
  # 4. apply scale factors
  quiz_score * DLEVEL_MULTIPLIERS[difficulty_level] * ARCADE_FACTOR
end




# # correct, but late
# p score_answer 1, 29, 2  # => 0
# p score_answer 1, 29, 1  # => 1.low
# p score_answer 1, 1,  1  # => 1.hight

ca = [1, 2]
pat = [
  [1, 29], # correct, low bonus
  [2, 29]  # correct, low bonus
]
dl = 1     # no multiplier

p score_quiz pat, ca, dl # 20000 (low end)

# ---

ca = [1, 2]
pat = [
  [1, 29], # correct, low bonus
  [2, 29]  # correct, low bonus
]
dl = 2     # 1.5x multiplier

p score_quiz pat, ca, dl # 350000 (low end)
