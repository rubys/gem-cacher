gem-cacher
==========

A simple sinatra app designed to cache gem services between rubygems.org and local network. 

When you set this server as a source for your gems, it will check to see if the gem already present in "gems" directory. If it is not, it will download the gem and return it in the original get request.

Why would you need it?
===============

In case you have a large Continuous Integration farm, that does a lot of gem installs and re-installs for builds. This caching server will reduce the time it takes to download gems from http://rubygems.org and will reduce the dependency on the internet connectivity from within your network.


Installation
===========

     git clone https://github.com/dimacus/gem-cacher.git
     cd gem-cacher
     gem install bundler
     bundler install
     bundle exec ruby gem-cacher.rb
      
     source "http://localhost:4567" (in your Gemfile)




Improvements
=========
If this is too simple for you and you would like to add more features to this bare bones service, please fork it and send me the patch
