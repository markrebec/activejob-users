module ActiveJob
  module Users
    extend ActiveSupport::Concern

    attr_accessor :job_user

    included do
      def serialize
        super.merge({ 'job_user' => job_user })
      end

      def deserialize(job_data)
        self.job_user = job_data["job_user"]
        super(job_data)
      end

      def enqueue(options = {})
        self.job_user = options[:job_user] if options[:job_user]
        super(options)
      end
    end

  end
end

ActiveJob::Base.send(:include, ActiveJob::Users)
