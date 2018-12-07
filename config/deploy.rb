# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "lifevitae"
set :repo_url, "git@github.com:rufoos/lifevitae.git"

set :bundle_binstubs, nil

set :deploy_to, '/var/www/lifevitae-staging'

set :scm, :git

set :filter, :roles => %w{app db}

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml'
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/sockets'
)

set :keep_releases, 5

set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma-out.log"
set :puma_error_log,  "#{release_path}/log/puma-err.log"
set :puma_conf, "#{shared_path}/config/puma.rb"

desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:app) do |host|
    info "env: #{fetch(:rails_env)}"
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end

before 'deploy:publishing', 'deploy:do_rake_tasks'
after 'deploy:updated', 'deploy:migrate'
after 'deploy:updated', 'deploy:webpack'

namespace :deploy do
  desc 'Setup'
  task :setup do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/"
      execute "mkdir -p #{shared_path}/config/"
      execute "mkdir -p #{shared_path}/log/"
      execute "mkdir -p #{shared_path}/tmp/pids/"
      execute "mkdir -p #{shared_path}/tmp/sockets/"
    end
  end

  desc 'Migrate DB'
  task :migrate do
    on roles(:db) do
      within release_path do
        with rack_env: fetch(:stage) do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  desc 'Build Vue'
  task :webpack do
    on roles(:app) do
      within release_path do
        with rack_env: fetch(:stage) do
          execute 'yarn install'
          execute "bin/webpack"
        end
      end
    end
  end

  task :do_rake_tasks do
    set :rake_tasks, ENV['rake_tasks'] ? ENV['rake_tasks'].split(',') : nil
    if fetch(:rake_tasks)
      on roles(:db) do
        within release_path do
          with rack_env: fetch(:stage) do
            fetch(:rake_tasks).each{ |task_name|
              execute :rake, task_name.strip
            }
          end
        end
      end
    end
  end

  task :restart do
    invoke 'puma:restart'
  end
end

namespace :nginx do
  %w[start stop restart reload].each do |command|
    desc "#{command.capitalize} nginx server"
    task command do
      on roles(:app) do
        sudo "service nginx #{command == 'restart' ? 'reload' : command}"
      end
    end
  end
end

