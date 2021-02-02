RSpec.describe Taking do
  it "has a version number" do
    expect(Taking::VERSION).not_to be nil
  end

  describe '.from_list' do
    it 'forwards Array-like arguments' do
      expect(Taking.from_list(1,2,3)).to eq([1,2,3])
    end

    it 'works with pattern matching' do
      def handle_responses(...) = case Taking.from_list(...)
        in 1, 2, 3  then :numbers
        in 'a', 'b' then :strings
        in :a, :b   then :symbols
        else             false
      end

      expect(handle_responses(1,2,3)).to eq(:numbers)
      expect(handle_responses('a', 'b')).to eq(:strings)
      expect(handle_responses(:a, :b)).to eq(:symbols)
      expect(handle_responses(:nope?)).to eq(false)
    end
  end

  describe '.from_kw' do
    it 'forwards Hash-like arguments' do
      expect(Taking.from_kw(a: 1, b: 2)).to eq({ a: 1, b: 2 })
    end

    it 'works with pattern matching' do
      def handle_responses(...) = case Taking.from_kw(...)
        in x: 0, y: 0    then :origin
        in x: 0, y: 10.. then :north
        else             false
      end

      expect(handle_responses(x: 0, y: 0)).to eq(:origin)
      expect(handle_responses(x: 0, y: 15)).to eq(:north)
      expect(handle_responses(x: 10, y: 15)).to eq(false)
    end
  end

  describe '.from' do
    it 'can handle both cases' do
      def handle_responses(...) = case Taking.from(...)
      in 1, 2, 3
        :numbers
      in 'a', 'b'
        :strings
      in :a, :b
        :symbols
      in x: 0, y: 0
        :origin
      in x: 0, y: (10..)
        :north
      else
        false
      end

      expect(handle_responses(1,2,3)).to eq(:numbers)
      expect(handle_responses('a', 'b')).to eq(:strings)
      expect(handle_responses(:a, :b)).to eq(:symbols)
      expect(handle_responses(:nope?)).to eq(false)
      expect(handle_responses(x: 0, y: 0)).to eq(:origin)
      expect(handle_responses(x: 0, y: 15)).to eq(:north)
      expect(handle_responses(x: 10, y: 15)).to eq(false)
    end

    it 'can even handle objects passed as a lead when they can be deconstructed' do
      Point = Struct.new(:x, :y)
      def handle_responses(...) = case Taking.from(...)
      in Point[x, 10 => y]
        Point[x, y + 1]
      in 1, 2, 3
        :numbers
      in 'a', 'b'
        :strings
      in :a, :b
        :symbols
      in x: 0, y: 0
        :origin
      in x: 0, y: (10..)
        :north
      else
        false
      end

      expect(handle_responses(Point[1, 10])).to eq(Point[1, 11])
    end
  end
end
