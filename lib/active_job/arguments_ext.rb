module ActiveJob
  module ArgumentsExt
    def serialize_variable(argument = nil)
      serialize_argument(argument)
    end

    def deserialize_variable(argument = nil)
      deserialize_argument(argument)
    end
  end
end

ActiveJob::Arguments.send(:extend, ActiveJob::ArgumentsExt)
