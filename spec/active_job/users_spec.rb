require 'spec_helper'

RSpec.describe ActiveJob::Users do
  subject { TestJob.new }

  context 'when a job_user argument is passed to the job' do
    let(:user) { {email: 'mark@markrebec.com'} }

    it 'extracts the job_user keyword argument' do
      subject.arguments << {job_user: user}
      subject.extract_job_user!

      expect(subject.job_user).to eq(user)
    end

    it 'passes other keyword arguments through' do
      subject.arguments << {job_user: user, foo: 'bar'}
      subject.extract_job_user!

      expect(subject.arguments.last).to eq({foo: 'bar'})
    end
  end

  context 'when a job_user argument is not passed to the job' do
    it 'sets the job_user to nil' do
      subject.extract_job_user!

      expect(subject.job_user).to eq(nil)
    end

    it 'passes all keyword arguments through' do
      subject.arguments << {foo: 'bar'}
      subject.extract_job_user!

      expect(subject.arguments.last).to eq({foo: 'bar'})
    end
  end

  describe 'around_perform' do
    it 'calls extract_job_user!' do
      expect_any_instance_of(TestJob).to receive(:extract_job_user!)
      TestJob.perform_now
    end
  end
end
