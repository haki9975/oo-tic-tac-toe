require 'pry'
class TicTacToe
    WIN_COMBINATIONS =[[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]
    attr_accessor :board, :counter

    def initialize
      @board = Array.new(9, " ")
        
    end

    def display_board  
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(string)
        string = string.to_i
        string = string -=1        
    end

    def move(index_of_board_array, players_token = x)
      @board[index_of_board_array] = players_token
    end

    def position_taken?(desired_move)
      if @board[desired_move] == "X" || @board[desired_move] == "O"
        return true
      else
        return false
      end
    end

    def valid_move?(desired_move)
     desired_move.between?(0, 8) && !position_taken?(desired_move)
    end

    def turn_count
      @board.count {|i| i == "X"|| i == "O" }
          
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        user_move = gets
          move_translation = input_to_index(user_move)
        if valid_move?(move_translation) 
          move(move_translation, current_player)
        else
          turn
        end
          display_board
    end

    def won? 
       WIN_COMBINATIONS.each do |combo|
          if @board[combo[0]] == "X" || @board[combo[0]] == "O" 
              if @board[combo[1]] == @board[combo[0]] && @board[combo[2]] == @board[combo[0]]
                  return combo
              end
          end
       end
        false
    end

    def full?
      @board.all? {|t| t != " "}
    end

    def draw?
      full? == true && won? == false ? true : false
    end

    def over?
        if draw? == true 
            return true
        elsif  won? != false
            return true
        else 
            return false
        end
    end

    def winner
        return nil if won? == false
       if won? != false 
          return @board[won?[0]]
        elsif won? == false
            return nil
        end
        
    end

   def play
       if over? != true && draw? != true
            turn 
            play
         #break if over? != false
          
        end

        if won? != false
            puts"Congratulations #{winner}!"
        elsif draw? != false
            puts "Cat's Game!"
        end
   end

   
    
end


