require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative 'dec_4'
require_relative 'dec_4_data'

class BingoTest < Minitest::Test 
  def test_board_can_make_bingo_board
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    assert_equal false, bingo_board.is_winner?
  end
  
  def test_board_can_mark_number
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    bingo_board.mark_number(22)
    is_marked = bingo_board.board[0][0][1] # second element in first element in first row
    assert_equal true, is_marked
  end
  
  def test_board_can_be_winner_row
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    [22,13,17,11,0].each { |num| bingo_board.mark_number(num)}
    assert_equal true, bingo_board.is_winner?
  end
  
  def test_board_can_be_winner_column
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    [22,8,21,6,1].each { |num| bingo_board.mark_number(num)}
    assert_equal true, bingo_board.is_winner?
  end
  
  def test_board_can_be_winner_diagonal_up
    skip
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    [1,10,14,4,0].each { |num| bingo_board.mark_number(num)}
    assert_equal true, bingo_board.is_winner?
  end
  
  def test_board_can_be_winner_diagonal_down
    skip
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    [22,2,14,18,19].each { |num| bingo_board.mark_number(num)}
    assert_equal true, bingo_board.is_winner?
  end
  
  def test_board_sum_unmarked_numbers
    input = SINGLE_BOARD
    bingo_board = BingoBoard.new(input)
    [22,2,14,18,19].each { |num| bingo_board.mark_number(num)}
    assert_equal 225, bingo_board.sum_of_unmarked_numbers
  end
  
  def test_game_sample_input
    input = SAMPLE_INPUT
    bingo = Bingo.new(input)
    assert_equal 24, bingo.last_number_drawn
    assert_equal 4512, bingo.final_score
  end
  
  def test_game_full_input
    input = FULL_INPUT
    bingo = Bingo.new(input)
    assert_equal 38, bingo.last_number_drawn
    assert_equal 28082, bingo.final_score
  end
  
  def test_losing_board_sample_input
    input = SAMPLE_INPUT
    bingo = Bingo.new(input)
    assert_equal 13, bingo.very_last_number_drawn
    assert_equal 1924, bingo.losing_score
  end
  
  def test_losing_board_full_input
    input = FULL_INPUT
    bingo = Bingo.new(input)
    assert_equal 8224, bingo.losing_score
  end
end