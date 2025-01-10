# Test Runner autonome intégré

class TestRunner
  @tests = []

  def self.describe(context, &block)
    puts "Context: #{context}"
    instance_eval(&block)
    run
  end

  def self.it(description, &block)
    @tests << { description: description, block: block }
  end

  def self.expect(actual)
    Expectation.new(actual)
  end

  def self.run
    @tests.each do |test|
      begin
        test[:block].call
        puts "✅ #{test[:description]}"
      rescue => e
        puts "❌ #{test[:description]} - #{e.message}"
      end
    end
  end

  class Expectation
    def initialize(actual)
      @actual = actual
    end

    def to_eq(expected)
      raise "Expected #{expected}, got #{@actual}" unless @actual == expected
    end
  end
end

# Tests
TestRunner.describe 'Atome Class' do
  it 'initializes with default values' do
    atome = Atome.new
    TestRunner.expect(atome.left).to_eq(0)
    TestRunner.expect(atome.color).to_eq('white')
  end

  it 'sets and gets the left value correctly' do
    atome = Atome.new
    atome.left(100)
    TestRunner.expect(atome.left).to_eq(100)
  end

  it 'sets and gets the color value correctly' do
    atome = Atome.new
    atome.color('red')
    TestRunner.expect(atome.color).to_eq('red')
  end
end