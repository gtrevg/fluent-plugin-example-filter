module Fluent
  class ExampleFilter < Filter

    Plugin.register_filter('example', self)

    # -- If you wanted to bring in tag keys --
    # include SetTagKeyMixin
    # config_set_default :include_tag_key, false


    # config_param works like other plugins
    config_param :example_string, :string, :default => nil
    config_param :example_bool, :bool, :default => false
    config_param :example_integer, :integer, :default => 1


    def configure(conf)
      super
      # do the usual configuration here
    end

    def start
      super
      # This is the first method to be called when it starts running
      # Use it to allocate resources, etc.
    end

    def shutdown
      super
      # This method is called when Fluentd is shutting down.
      # Use it to free up resources, etc.
    end

    def filter(tag, time, record)
      # This method implements the filtering logic for individual filters
      # It is internal to this class and called by filter_stream unless
      # the user overrides filter_stream.
      #
      # Since our example is a pass-thru filter, it does nothing and just
      # returns the record as-is.
      # If it returns nil, that record is ignored.
      record
    end

    # This is the filter_stream implmentation in the superclass.  It
    # can be a starting point if you are interested in overriding the
    # filter_stream method
    
    # def filter_stream(tag, es)
    #   # super
    #   new_es = MultiEventStream.new
    #   es.each { |time, record|
    #     begin
    #       filtered_record = filter(tag, time, record)
    #       new_es.add(time, filtered_record) if filtered_record
    #     rescue => e
    #       router.emit_error_event(tag, time, record, e)
    #     end
    #   }
    #   new_es
    # end
  end
end
