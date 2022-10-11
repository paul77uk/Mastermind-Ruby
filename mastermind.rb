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
    ] # {color('black')}]
    @guessing_colors_arr = ["\u25CB " * 4] * 10
    @input = nil
    @correct_guess_arr = ["\u2715 " * 4] * 10
    @index_number = 0
  end

  def display # rubocop:disable Metrics/MethodLength
    "     1 2 3 4 5 6 7 8\     \n "\
    "    #{YELLOW_PEG} #{WHITE_PEG} #{RED_PEG} #{ORANGE_PEG} #{GREEN_PEG} #{BROWN_PEG} #{BLUE_PEG} #{BLACK_PEG}\n\n" \
    "10  #{"\u25CB " * 4}  #{@correct_guess_arr[9]}\n" \
    "9   #{"\u25CB " * 4}  #{@correct_guess_arr[8]}\n" \
    "8   #{"\u25CB " * 4}  #{@correct_guess_arr[7]}\n" \
    "7   #{"\u25CB " * 4}  #{@correct_guess_arr[6]}\n" \
    "6   #{"\u25CB " * 4}  #{@correct_guess_arr[5]}\n" \
    "5   #{"\u25CB " * 4}  #{@correct_guess_arr[4]}\n" \
    "4   #{"\u25CB " * 4}  #{@correct_guess_arr[3]}\n" \
    "3   #{"\u25CB " * 4}  #{@correct_guess_arr[2]}\n" \
    "2   #{"\u25CB " * 4}  #{@correct_guess_arr[1]}\n" \
    "1   #{@guessing_colors_arr[0]}  #{@correct_guess_arr[0]}"
    # "1   #{"\u25CB " * 4}  #{color('correct')} \u2714 \u2715 \u2715"
  end

  def color(color)
    str = "\u25CF"
    correct = "\u2714"
    return "\e[38;2;0;128;0m#{correct}\e[0m" if color == 'correct'
    return "\e[38;2;220;20;60m#{str}\e[0m" if color == 'red'
    return "\e[38;2;30;144;255m#{str}\e[0m" if color == 'blue'
    return "\e[38;2;255;255;0m#{str}\e[0m" if color == 'yellow'
    return "\e[38;2;255;165;0m#{str}\e[0m" if color == 'orange'
    return "\e[38;2;0;255;0m#{str}\e[0m" if color == 'green'
    return "\e[38;2;139;69;19m#{str}\e[0m" if color == 'brown'
    return "\e[38;2;255;255;255m#{str}\e[0m" if color == 'white'
    return "\e[38;2;0;0;0m#{str}\e[0m" if color == 'black'
  end

  def computer_colors
    %w[1 2 3 4]
  end

  def enter_colors_guess
    puts 'Enter your guess:'
    @input = gets.chomp
  end

  def guess_correct?
    @input == computer_colors.join
  end

  def update_guess_color_row
    guessing_line = @input.split('').map { |num| "#{@colors[num.to_i]} " }
    @guessing_colors_arr[0] = guessing_line.join
  end

  def update_correct_guesses
    correct_peg_position_arr = []
    correct_peg_arr = []
    incorrect_peg_arr = []
    # @correct_guess_arr.length.times do |number|
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
    # end
  end
end

puts
mastermind = MasterMind.new
puts mastermind.display
10.times do
  puts
  # mastermind.display
  # puts
  mastermind.enter_colors_guess
  puts mastermind.guess_correct?
  mastermind.update_guess_color_row
  mastermind.update_correct_guesses
  system 'clear'
  puts mastermind.display
end
