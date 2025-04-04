class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    # Handle custom delimiters
    if numbers.start_with?("//")
      delimiter_section, rest_of_numbers = numbers[2..-1].split("\n", 2)

      # Handle missing delimiter after "//"
      if delimiter_section.empty?
        raise ArgumentError, "Delimiter missing after '//'"
      end

      # Extract multiple delimiters if present, delimited by ']['
      delimiters = []
      if delimiter_section.start_with?('[') && delimiter_section.end_with?(']')
        delimiter_section[1..-2].split('][').each { |d| delimiters << Regexp.escape(d) }
      else
        delimiters << Regexp.escape(delimiter_section)  # Single delimiter case
      end

      # Join all delimiters to create a regex pattern that matches any of them
      delimiter_regex = /#{delimiters.join('|')}/
      numbers = rest_of_numbers
    else
      delimiter_regex = /[\n,]/
    end

    # Split the numbers based on the delimiter(s)
    nums = numbers.split(delimiter_regex)

    # Check for negative numbers
    negatives = nums.select { |num| num.to_i < 0 }

    if negatives.any?
      raise "negative numbers not allowed: #{negatives.join(',')}"
    end

    nums.map(&:to_i).select { |num| num <= 1000 }.sum
  end
end
