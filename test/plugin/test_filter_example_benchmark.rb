require 'fluent/test'
require 'fluent/plugin/filter_example'
require 'benchmark'

class BenchmarkExampleFilter < Test::Unit::TestCase

  def setup
    Fluent::Test.setup
    @num_iterations = 10000
  end

  def driver(conf = '', tag = 'test.example.tag', block = true)
    Fluent::Test::FilterTestDriver.new(Fluent::ExampleFilter, tag).configure(conf, block)
  end

  def sample_record
    {'some_string' => 'string_value', 'some_int' => 42, 'some_float' => 1.5, 'some_bool' => true }
  end


  def test_benchmark_example_filter

    record = sample_record

    Benchmark.bm(24) do |bm|
      d = driver()
      bm.report("driver_default_configs") {
        d.run { @num_iterations.times { d.emit( record ) } }
      }

      d = driver(%{
        example_string     my_string
        example_bool       false
        example_integer    1234
      })
      bm.report("driver_custom_configs") {
        d.run { @num_iterations.times { d.emit( record ) } }
      }

    end
  end


end
