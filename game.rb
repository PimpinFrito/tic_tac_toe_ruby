class Board
  attr_reader :current_turn
  LINES = [[0, 1, 2], [3, 4, 5], [6, 7, 8],  # ROWS
           [0, 3, 6], [1, 4, 7], [2, 5, 8], # COLUMNS
           [0, 4, 8], [2, 4, 6]].freeze         # CROSS

  def initialize
    @positions = reset_board
    @current_turn = 'x'
    display_board
  end

  def change_turns
    @current_turn = if @current_turn == 'x'
                      'o'
                    else
                      'x'
                    end
  end

  def reset_board
    @positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def addPiece(position)
    position -= 1
    location_value = @positions[position]
    if location_value != 'x' && location_value != 'o'
      @positions[position] = @current_turn
    else
      puts "Can't move here!"
    end
    game_won?(current_turn)
    change_turns
  end

  def display_board
    puts @positions.slice(0, 3).join("\t|\t")
    puts '-----------------'
    puts @positions.slice(3, 3).join("\t|\t")
    puts '-----------------'
    puts @positions.slice(6, 3).join("\t|\t")
  end

  def game_won?(mark)
    display_board()
    won = LINES.any? { |row| row.all? { |index| @positions[index] == mark } }
    if won
      puts "#{mark} won the game!"
      sleep 5
      reset_board
      display_board
    end
  end
end

board = Board.new

loop do
  puts "It's #{board.current_turn}'s move"
  puts 'Where to move:'
  position = gets.to_i
  if position > 9 || position <1
    break
  else
    board.addPiece(position)
  end
end
