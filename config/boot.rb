ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

require 'toxiproxy'
Toxiproxy.populate(File.join(File.dirname(File.expand_path(__FILE__)), "/toxiproxy.json"))
