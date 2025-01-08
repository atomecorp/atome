# runner.rb - Minimal test runner for both Opal and Ruby Wasm
class TestRunner
  def self.describe(context, &block)
    puts "Context: #{context}"
    instance_eval(&block)
  end

  def self.it(description, &block)
    begin
      block.call
      puts "✅ #{description}"
    rescue => e
      puts "❌ #{description} - #{e.message}"
    end
  end

  def self.expect(actual)
    Expectation.new(actual)
  end

  class Expectation
    def initialize(actual)
      @actual = actual
    end

    def to_eq(expected)
      raise "Expected #{@actual}, got #{expected}" unless @actual == expected
    end
  end
end

# my_tests.rb - Tests using browser context
require_relative 'runner'

TestRunner.describe 'Atome Class in Browser' do
  it 'sets and gets the left value correctly in the browser' do
    `var atome = new Atome();`
    `atome.left(100);`
    left_value = `atome.left()`
    TestRunner.expect(left_value).to_eq(100)
  end

  it 'sets and gets the color value correctly in the browser' do
    `var atome = new Atome();`
    `atome.color("red");`
    color_value = `atome.color()`
    TestRunner.expect(color_value).to_eq("red")
  end
end
