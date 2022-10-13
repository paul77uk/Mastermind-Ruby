class Peg
  private

  attr_accessor :color, :numbers, :unicode

  def initialize(color, numbers = nil, unicode: "\u25CF")
    self.color = color
    self.numbers = numbers
    self.unicode = unicode
  end

  def to_s
    "\e[38;2;#{@color}m#{@unicode}\e[0m"
  end
end

class MasterMind
  YELLOW_PEG = Peg.new('255;255;0', 1)
  WHITE_PEG = Peg.new('255;255;255', 2)
  RED_PEG = Peg.new('220;20;60', 3)
  ORANGE_PEG = Peg.new('255;165;0', 4)
  GREEN_PEG = Peg.new('0;255;0', 5)
  BROWN_PEG = Peg.new('139;69;19', 6)
  BLUE_PEG = Peg.new('30;144;245', 7)
  BLACK_PEG = Peg.new('0;0;0', 8)
  CORRECT_PEG_POSITION = Peg.new('0;128;0', unicode: "\u2714")
  CORRECT_PEG = Peg.new('0;0;0', unicode: "\u2714")
  INCORRECT_PEG = Peg.new('0;0;0', unicode: "\u2715")

  def initialize
    @colors = [
      "\u25CB", YELLOW_PEG, WHITE_PEG, RED_PEG, ORANGE_PEG, GREEN_PEG, BROWN_PEG, BLUE_PEG, BLACK_PEG
    ]
    @guessing_colors_arr = ["\u25CB " * 4] * 10
    @input = nil
    @correct_guess_arr = ["\u2715 " * 4] * 10
    @index_number = 0
  end

  def display
    "     1 2 3 4 5 6 7 8\     \n "\
    "    #{YELLOW_PEG} #{WHITE_PEG} #{RED_PEG} #{ORANGE_PEG} #{GREEN_PEG} #{BROWN_PEG} #{BLUE_PEG} #{BLACK_PEG}\n\n" \
    "10  #{@guessing_colors_arr[9]}  #{@correct_guess_arr[9]}\n" \
    "9   #{@guessing_colors_arr[8]}  #{@correct_guess_arr[8]}\n" \
    "8   #{@guessing_colors_arr[7]}  #{@correct_guess_arr[7]}\n" \
    "7   #{@guessing_colors_arr[6]}  #{@correct_guess_arr[6]}\n" \
    "6   #{@guessing_colors_arr[5]}  #{@correct_guess_arr[5]}\n" \
    "5   #{@guessing_colors_arr[4]}  #{@correct_guess_arr[4]}\n" \
    "4   #{@guessing_colors_arr[3]}  #{@correct_guess_arr[3]}\n" \
    "3   #{@guessing_colors_arr[2]}  #{@correct_guess_arr[2]}\n" \
    "2   #{@guessing_colors_arr[1]}  #{@correct_guess_arr[1]}\n" \
    "1   #{@guessing_colors_arr[0]}  #{@correct_guess_arr[0]}"
  end

  def computer_colors
    %w[1 2 3 4]
  end

  def enter_colors_guess
    puts "\nEnter your guess:"
    @input = gets.chomp
  end

  def guess_correct?
    @input == computer_colors.join
  end

  def update_guess_color_row
    guessing_line = @input.split('').map { |num| "#{@colors[num.to_i]} " }
    @guessing_colors_arr[@index_number] = guessing_line.join
  end

  def win?
    "\nWell Done you guessed in #{@index_number}\n\n" if guess_correct?
  end

  def update_correct_guesses
    correct_peg_position_arr = []
    correct_peg_arr = []
    incorrect_peg_arr = []
    computer_colors.each_with_index do |color, index|
      if color == @input[index]
        correct_peg_position_arr << "#{CORRECT_PEG_POSITION} "
      elsif @input.split('').include?(color)
        correct_peg_arr << "#{CORRECT_PEG} "
      else
        incorrect_peg_arr << "#{INCORRECT_PEG} "
      end
    end
    @correct_guess_arr[@index_number] = correct_peg_position_arr.join + correct_peg_arr.join + incorrect_peg_arr.join
    correct_peg_position_arr.clear
    correct_peg_arr.clear
    incorrect_peg_arr.clear
    @index_number += 1
  end
end

puts
mastermind = MasterMind.new
puts mastermind.display
10.times do
  mastermind.enter_colors_guess
  puts mastermind.guess_correct?
  mastermind.update_guess_color_row
  mastermind.update_correct_guesses
  system 'clear'
  puts mastermind.display
  puts mastermind.win?
  return if mastermind.guess_correct?
end
