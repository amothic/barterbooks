# Barter Books

This is the application for bollowing books online

Installation
------------

Once you have these:

    # Checkout the project
    $ git clone git://github.com/amothic/barterbooks.git
    $ cd barterbooks

    # Install the project dependencies
    $ gem install bundler
    $ bundle install

    # Set up the development database
    $ bundle exec rake db:migrate

    # Start the local web server
    $ rails server

You should then be able to navigate to `http://localhost:3000/` in a web browser.
