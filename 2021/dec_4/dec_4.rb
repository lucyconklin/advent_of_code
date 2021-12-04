class Bingo
  attr_reader :last_number_drawn, :very_last_number_drawn
  
  def initialize(game)
    game = game.split(/\n\n/)
    @drawn_numbers = game[0].split(',')
    game.shift #remove the first element, we have stored that above
    boards = game #remaining elements are bingo boards
    @bingo_boards = []
    create_boards(boards)
    @last_number_drawn
    @very_last_number_drawn
    @winning_board
    @losing_board
    start_game
  end
  
  def start_game
    @drawn_numbers.each do |number|
      @bingo_boards.each do |board|
        board.mark_number(number.to_i)
      end
      if has_winner? && !@winning_board
        @last_number_drawn = number.to_i
        @winning_board = winner
      end
      # filter for losing boards only
      if @bingo_boards.length > 1
        # keep filtering
        @bingo_boards = @bingo_boards.select {|b| !b.is_winner? }
      else 
        # we know which board wins last
        @losing_board = @bingo_boards[0]
      end
      
      if @losing_board && @losing_board.is_winner?
        # last board finally wins, keep number
        # we already know which board it is
        @very_last_number_drawn = number.to_i
        break
      end
    end
  end
  
  def create_boards(bingo_boards)
    bingo_boards.each do |board|
      board = BingoBoard.new(board)
      @bingo_boards << board
    end
  end
  
  def has_winner?
    @bingo_boards.any? { |board| board.is_winner? }
  end
  
  def winner
    @bingo_boards.find { |board| board.is_winner? }
  end
  
  def final_score
    @winning_board.sum_of_unmarked_numbers * @last_number_drawn
  end
  
  def losing_score
    @losing_board.sum_of_unmarked_numbers * @very_last_number_drawn
  end
end

class BingoBoard  
  attr_reader :board
  
  def initialize(board)
    make_board(board)
  end
  
  def make_board(board)
    @board = board.split(/\n/).map do |row| # like '22 13 17 11 0'
      row.split(' ').map do |num| # like [22, 13, 17, 11, 0]
        [num, false]
      end 
    end
  end
  
  def mark_number(num)
    @board.each do |row|
      row.each do |square|
        if square[0].to_i == num
          square[1] = true
        end
      end
    end
  end
  
  def is_winner?
    is_row_winner? || is_column_winner? || false
  end
  
  def is_row_winner?
    @board.any? do |row|
      row.all? { |elem| elem[1] }
    end
  end
  
  def is_column_winner?
    columns = @board.map.with_index do |row, i|
      row.map.with_index do |_elem, j|
        @board[j][i]
      end
    end
    columns.any? do |row|
      row.all? { |elem| elem[1] }
    end
  end
  
  def is_diagonal_winner?
    diagonal_down_winner = @board.map.with_index do |row,i|
      row[i]
    end.all? {|elem| elem[1]}
    diagonal_up_winner = @board.map.with_index do |row,i|
      row.reverse[i]
    end.all? {|elem| elem[1]}
    diagonal_down_winner || diagonal_up_winner || false
  end
  
  def sum_of_unmarked_numbers
    sum = @board.map do |row|
      row.map do |elem|
        !elem[1] ? elem[0].to_i : 0
      end
    end.flatten.reduce(&:+)
    sum
  end
end