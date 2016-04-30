# ActiveJob::Users

[![Build Status](https://travis-ci.org/markrebec/activejob-users.png)](https://travis-ci.org/markrebec/activejob-users)
[![Coverage Status](https://coveralls.io/repos/markrebec/activejob-users/badge.svg)](https://coveralls.io/r/markrebec/activejob-users)
[![Code Climate](https://codeclimate.com/github/markrebec/activejob-users.png)](https://codeclimate.com/github/markrebec/activejob-users)
[![Gem Version](https://badge.fury.io/rb/activejob-users.png)](http://badge.fury.io/rb/activejob-users)
[![Dependency Status](https://gemnasium.com/markrebec/activejob-users.png)](https://gemnasium.com/markrebec/activejob-users)

`ActiveJob::Users` allows you to pass a `job_user` argument through to your jobs for context and makes it accessible within your `MyJob#perform` method. This can be useful when you have jobs that are triggered by users through some interface (i.e. an admin portal) and you want to preserve that `current_user`-style context within your job execution.

It's used by [`audited-activejob`](https://github.com/markrebec/audited-activejob) to set the user association for audits generated in background jobs.

## Getting Started

Just add the gem to your `Gemfile` and run `bundle install`:

    gem 'activejob-users'

## Usage

The gem provides a `job_user` method to any jobs that include the `ActiveJob::Users` mixin, which you can use however you like within your jobs. You can populate this when queueing up your job by passing a `job_user: user` keyword argument. **Note: You do not need to modify your job's `MyJob#perform` method to accept this extra argument.**

```ruby
class MyJob < ActiveJob::Base
  include ActiveJob::Users
  queue_as :default

  def perform
    Rails.logger.info "Executed MyJob for #{job_user.try(:email) || 'unknown'}"
  end
end

# without a user
MyJob.perform_later
# writes "Executed MyJob for unknown" to the rails log

# with a user
MyJob.perform_later job_user: User.find_by(email: 'mark@markrebec.com')
# writes "Executed MyJob for mark@markrebec.com" to the rails log

# if you're in a controller or some other context where you already have a current_user
# you'll probably just want to pass that through.
MyJob.perform_later job_user: current_user
```

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
