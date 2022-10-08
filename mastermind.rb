require 'colorize'

class MasterMind
  def display # rubocop:disable Metrics/MethodLength
    "     1 2 3 4 5 6 7 8\     \n "\
    "    #{color('yellow')} #{color('white')} #{color('red')} #{color('orange')} #{color('green')} #{color('brown')} #{color('blue')} #{color('black')}\n\n" \
    "10  #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "9   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "8   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "7   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "6   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "5   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "4   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "3   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "2   #{"\u25CB " * 4}  \u2715 \u2715 \u2715 \u2715\n" \
    "1   #{"\u25CB " * 4}  #{"\u2714".green} \u2714 \u2715 \u2715"
  end
end

def color(color)
  str = "\u25CF"
  return "\e[38;2;220;20;60m#{str}\e[0m" if color == 'red'
  return "\e[38;2;30;144;255m#{str}\e[0m" if color == 'blue'
  return "\e[38;2;255;255;0m#{str}\e[0m" if color == 'yellow'
  return "\e[38;2;255;165;0m#{str}\e[0m" if color == 'orange'
  return "\e[38;2;0;255;0m#{str}\e[0m" if color == 'green'
  return "\e[38;2;139;69;19m#{str}\e[0m" if color == 'brown'
  return "\e[38;2;255;255;255m#{str}\e[0m" if color == 'white'
  return "\e[38;2;0;0;0m#{str}\e[0m" if color == 'black'
end

puts
mastermind = MasterMind.new
puts mastermind.display
puts
