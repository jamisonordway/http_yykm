require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'simplecov'
SimpleCov.start do
  add_filter 'lib/server'
end 
