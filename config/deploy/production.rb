server '192.168.1.59', user: 'kali', roles: %w[app db web resque_worker]

set :resque_environment_task, true

set :workers, { "#{fetch(:application)}*" => 1 }
