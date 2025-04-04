require 'rspec'
require_relative '../string_calculator'

RSpec.describe StringCalculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(StringCalculator.add('')).to eq(0)
    end

    it 'returns the number for a single number' do
      expect(StringCalculator.add('1')).to eq(1)
    end

    it 'returns the sum for two numbers' do
      expect(StringCalculator.add('1,5')).to eq(6)
    end

    it 'returns the sum for multiple numbers' do
      expect(StringCalculator.add('1,2,3')).to eq(6)
    end

    it 'handles newline-separated numbers' do
      expect(StringCalculator.add("1\n2,3")).to eq(6)
    end

    it 'supports custom delimiters' do
      expect(StringCalculator.add("//;\n1;2")).to eq(3)
    end

    it 'raises an error for a missing delimiter after "//"' do
      expect { StringCalculator.add("//\n1,2") }.to raise_error(ArgumentError, "Delimiter missing after '//'")
    end

    it 'raises an error for a negative number' do
      expect { StringCalculator.add("1,-2,3") }.to raise_error("negative numbers not allowed: -2")
    end

    it 'raises an error for multiple negative numbers' do
      expect { StringCalculator.add("1,-2,-3") }.to raise_error("negative numbers not allowed: -2,-3")
    end

    it 'handles custom multi-character delimiters' do
      expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it 'raises an error for a single negative number' do
      expect { StringCalculator.add("//;\n-1") }.to raise_error("negative numbers not allowed: -1")
    end

    it 'handles multiple delimiters' do
      expect(StringCalculator.add("//[***][#]\n1***2#3")).to eq(6)
    end

    it 'raises an error if delimiter is not specified correctly' do
      expect { StringCalculator.add("//\n1,2") }.to raise_error(ArgumentError)
    end

    it 'Tests for Large Numbers' do
      expect(StringCalculator.add("1000,1000")).to eq(2000)
    end

    it 'Test for Numbers Greater Than 1000' do
      expect(StringCalculator.add("1000,2000")).to eq(1000) #(Ignore Numbers Greater Than 1000)
    end
  end
end
