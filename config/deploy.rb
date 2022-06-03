# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "eventmaker"
set :repo_url, "git@github.com:emfy0/event_maker.git"

set :deploy_to, "/home/deploy/www"

append :linked_files, "config/database.yml", 'config/master.key'
