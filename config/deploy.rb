# config valid for current version and patch releases of Capistrano
lock '~> 3.17.0'

set :application, 'eventmaker'
set :repo_url, 'git@github.com:emfy0/event_maker.git'
set :branch, :main

set :deploy_to, '/home/deploy/www'

set :nvm_node, 'v16.15.0'
set :nvm_type, :user
set :nvm_map_bins, %w[node npm yarn]

after 'deploy:restart', 'resque:restart'

append :linked_files, 'config/database.yml', 'config/master.key'
