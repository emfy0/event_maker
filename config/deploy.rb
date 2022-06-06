# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "eventmaker"
set :repo_url, "git@github.com:emfy0/event_maker.git"
set :branch, :main

set :deploy_to, "/home/kali/www"

set :bundle_check_before_install, false

set :rvm_type, :user
set :rvm_ruby_version, '3.0.2'

set :nvm_node, 'v16.15.1'
set :nvm_type, :user
set :nvm_map_bins, %w[node npm yarn]

append :linked_files, "config/database.yml", 'config/master.key'
