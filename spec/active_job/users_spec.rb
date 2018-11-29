require 'spec_helper'

RSpec.describe ActiveJob::Users do
  subject { TestJob.new }

  context 'when a job_user argument is passed to the job' do
    let(:user) { {email: 'mark@markrebec.com'} }

    it 'extracts the job_user keyword argument' do
      subject.job_user = user
      expect(subject.job_user).to eq(user)
    end

    it 'passes other keyword arguments through' do
      subject.job_user = user
      subject.arguments << {foo: 'bar'}
      expect(subject.arguments.last).to eq({foo: 'bar'})
    end

    it 'serialize the job_user' do
      subject.job_user = user
      expect(subject.serialize["job_user"]['email']).to eq(user[:email])
    end

    it 'deserialize the job_user' do
      subject.job_user = user
      job = TestJob.deserialize(subject.serialize)
      expect(job.job_user).to eq(user)
    end

    it 'passes job_user in enqueue' do
      subject.enqueue(job_user: user)
      expect(subject.job_user).to eq(user)
    end

    it 'passes job_user in set' do
      expect_any_instance_of(TestJob).to receive(:job_user)
      TestJob.set(job_user: user).perform_later
    end
  end

  context 'when a job_user is not passed to the job' do
    it 'sets the job_user to nil' do
      expect(subject.job_user).to eq(nil)
    end

    it 'passes all keyword arguments through' do
      subject.arguments << {foo: 'bar'}
      expect(subject.arguments.last).to eq({foo: 'bar'})
    end

    it 'serialize the job_user' do
      expect(subject.serialize["job_user"]).to eq(nil)
    end

    it 'deserialize the job_user' do
      job = TestJob.deserialize(subject.serialize)
      expect(job.job_user).to eq(nil)
    end

    it 'passes job_user in enqueue' do
      subject.enqueue(job_user: nil)
      expect(subject.job_user).to eq(nil)
    end

    it 'passes job_user in set' do
      expect_any_instance_of(TestJob).to receive(:job_user)
      TestJob.perform_later
    end
  end

  it 'respond_to job_user' do
    expect(subject).to respond_to(:job_user)
  end
end
