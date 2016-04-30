module ActiveJob
  module Users
    def self.included(base)
      base.send :attr_reader, :job_user
      base.send :before_perform, :extract_job_user!
    end

    def extract_job_user!
      options = arguments.extract_options!
      @job_user = options.delete(:job_user)
      arguments << options unless options.empty?
    end
  end
end
