class Funnel
  def initialize
    @elements = Array.new 15, nil
  end

  def elements
    @elements
  end

  def fill *args
    while args.any?
      free_index = @elements.index(nil)

      break unless free_index

      @elements[free_index] = args.shift
    end
  end

  def drip
    dripped = @elements.first

    j = 0
    1.upto(5).each do |i|
      @elements[index(i, j)] = nil
      new_j = replacement_j(i, j)
      break unless new_j
      @elements[index(i, j)] = row(i + 1)[new_j]
      @elements[index(i + 1, new_j)] = nil
      j = new_j
    end

    dripped
  end

  def to_s
    5.downto(1).map do |i|
      "#{' ' * (5 - i)}\\#{row(i).map { |e| e ? e : ' ' }.join(' ')}/"
    end.join "\n"
  end

  def fill_the_gap
    last_present_element_index = @elements.reverse.index { |x| !x.nil? }

    x = @elements.reverse[0..last_present_element_index]
  end

  def weight_above(i, j)
    above(i, j).size
  end

  def replacement_j(i, j)
    left = j
    right = [(j + 1), row(i + 1).size - 1].min

    if !row(i + 1)[left] && !row(i + 1)[right]
      nil
    elsif !row(i + 1)[left]
      right
    elsif !row(i + 1)[right]
      left
    else
      if weight_above(i + 1, left) >= weight_above(i + 1, right)
        left
      else
        right
      end
    end
  end

  def above(i, j, depth=0)
    return [] if i > 5
    return [] unless row(i)[j]

    up = i + 1
    left = j
    right = [(j + 1), row(up).size - 1].min

    [
      index(up, left),
      above(up, left, depth+1),
      index(up, right),
      above(up, right, depth+1)
    ].flatten.compact.uniq
  end

  def index(i, j)
    1.upto(i).sum - (i - j)
  end

  def row(index)
    offset = 5.downto(index + 1).sum
    @elements[-(offset + index)..-(offset + 1)]
  end

  def last_present_index
    @elements.reverse.index { |x| !x.nil? }
  end
end
