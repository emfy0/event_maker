require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/rails'
require 'capistrano/passenger'
require 'capistrano/nvm'
require 'capistrano-resque'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
