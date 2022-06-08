server '62.113.103.13', user: 'deploy', roles: %w[app db web resque_worker]

set :resque_environment_task, true

set :workers, { "#{fetch(:application)}*" => 1 }
