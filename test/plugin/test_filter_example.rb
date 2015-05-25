require 'fluent/test'
require 'fluent/plugin/filter_example'


class ExampleFilter < Test::Unit::TestCase

  def setup
    Fluent::Test.setup
  end

  def driver(conf = '', tag = 'test.example.tag', block = true)
    Fluent::Test::FilterTestDriver.new(Fluent::ExampleFilter, tag).configure(conf, block)
  end

  def sample_record
    {'some_string' => 'string_value', 'some_int' => 42, 'some_float' => 1.5, 'some_bool' => true }
  end


  def test_configure_defaults
    instance = driver().instance

    assert_equal nil, instance.example_string
    assert_equal false, instance.example_bool
    assert_equal 1, instance.example_integer
  end

  def test_configure_1
    config = %{
      example_string     my_string
      example_bool       false
      example_integer    1234
    }
    instance = driver(config).instance

    assert_equal 'my_string', instance.example_string
    assert_equal false, instance.example_bool
    assert_equal 1234, instance.example_integer
  end

  def test_configure_2
    config = %{
      example_string     another_string
      example_bool       true
      example_integer    0
    }
    instance = driver(config).instance

    assert_equal 'another_string', instance.example_string
    assert_equal true, instance.example_bool
    assert_equal 0, instance.example_integer
  end


  def test_filter_sample_record
    d = driver()
    d.emit(sample_record)
    d.run

    records = d.emits # you can also use d.filtered_as_array
    tag, ts, record = records[0]
    assert_equal('test.example.tag', tag)
    assert_equal(sample_record, record)

    # if you want to iterate through the records, you can also:
    # d.filtered.each { |time, record|
    #   assert_equal(some, comparison)
    # }

  end


end
