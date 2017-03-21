FROM phusion/passenger-ruby23:0.9.20

# Set correct environment variables.
ENV HOME /root

# Use phusion baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose Nginx HTTP port
EXPOSE 80

# Enable Nginx / Passenger on start
RUN rm -f /etc/service/nginx/down

# Install bundle of gems
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN gem install bundler
RUN bundle install

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Add the Rails app
ADD . /home/app/webapp
RUN cp /home/app/webapp/config/database_prod.yml /home/app/webapp/config/database.yml
RUN chown -R app:app /home/app/webapp

WORKDIR /home/app/webapp
RUN RAILS_ENV=production rake assets:precompile
