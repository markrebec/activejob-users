module ActiveJob
  module Users
    def self.included(base)
      base.send :attr_reader, :job_user

      base.send :around_perform do |_job, block|
        extract_job_user!

        block.call
      end

      def extract_job_user!
        options = arguments.extract_options!
        @job_user = options.delete(:job_user)
        arguments << options unless options.empty?
      end
    end
  end
end
