CheckMed
========

Production server ip address: [34.204.218.138](http://34.204.218.138/)

This is Ruby on Rails project,
partially based on [Mayak Rails website template](http://mayak.io/).


Getting Started
---------------

Make sure you have Ruby version installed, specified in the `.ruby-version`
file in the root directory of the application.

If you use [RVM](https://rvm.io/) add a '.ruby-gemset'
[file](https://rvm.io/workflow/projects#project-file-ruby-version)
to the root directory of the application.

You will need [ImageMagick](https://www.imagemagick.org/) installed.

The application uses PostgreSQL. Versions 8.2 and up are supported.
Create database and config file `config/database.yml` for connection.
File example:

    development:
      adapter: postgresql
      database: database_name
      pool: 5

There is `config/database_example.yml` file for full example.

When done, run:

    $ bin/bundle install --without production
    $ bin/rake db:create db:migrate

Install demo data using command: `bin/rake db:seed` if you need.

Application ready for start. You can launch webserver with
command `bin/rails server` and see home page
at [localhost:3000](http://localhost:3000/) url.


A Little Helpers
----------------

When you need to show the Exception, but you have no access
to the production logs add lines to controller:

    # override create method
    def create
        begin
          super
        rescue Exception => e
          @ex_on = e
          self.resource = resource_class.new # necessary for the view
          render action: 'new'
        end
      end

And to the view:

    - if @ex_on
      p = @ex_on.message
      p = @ex_on.backtrace.inspect
