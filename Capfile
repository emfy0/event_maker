require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/rails'
require 'capistrano/passenger'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
