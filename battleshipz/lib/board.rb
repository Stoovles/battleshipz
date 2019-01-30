


def letter_converter(width, length)
  alphabet = ("A".."Z").to_a
  width_letter_array = (1..width).map do |num|
    num = alphabet[num - 1]
  end
  other_array = []
  width_letter_array.cycle(length) do |letter|
    other_array << letter
  end
  other_array.sort!
  counter = 1
  the_real_other = []
  other_array.each do |letter|
    the_real_other << letter + counter.to_s
    counter += 1
    if counter > length
      counter = 1
    end
  end
  the_real_other
end
