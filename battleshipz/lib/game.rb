

# def start
#   puts "Welcome! You're playing with #{@deck.count} cards."
#   puts "-------------------------------------------------"
#   play_game
#   game_over
# end


# def play_game
#   @deck.cards.each do |card|
#     puts "This is card number #{@current_card_index + 1} out of #{@deck.count}."
#     puts "Question: #{current_card.question}"
#     guess = gets.chomp
#     turn = take_turn(guess)
#     puts turn.feedback
#     puts "-------------------------------------------------"
#   end
# end
#
# def game_over
#   puts "****** Game over! ******"
#   puts "You had #{number_correct} correct guesses out of #{@turns.count} for a total score of #{percent_correct}%."
#   @deck.card_categories.each do |category|
#     puts "#{category}: #{percent_correct_by_category(category)}% correct."
#   end
# end
