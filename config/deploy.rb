require 'capistrano_colors'

set :application, 'gether.ly'
set :repository,  'git@github.com:transist/gether.ly.git'
set :scm, :git
set :deploy_via, :remote_cache
set :use_sudo, false
set :user, 'deploy'

set :bundle_flags, '--deployment --quiet --binstubs'
set :bundle_without, [:development, :test]
require 'bundler/capistrano'

task :staging do
  role :app, 'staging.getherly.com'
  role :web, 'staging.getherly.com'
  role :db,  'staging.getherly.com', primary: true
  set :branch, 'master'
  set :rails_env, 'production'
  set :deploy_to, '/var/www/staging.getherly.com'
end

task :production do
  role :app, 'getherly.com'
  role :web, 'getherly.com'
  role :db,  'getherly.com', primary: true
  set :branch, 'master'
  set :rails_env, 'production'
  set :deploy_to, '/var/www/getherly.com'
end

before 'deploy:finalize_update', roles: :app do
  run <<-BASH
    cd #{current_release} &&
    rm -rf #{current_release}/config/mongoid.yml &&
    ln -s #{shared_path}/config/mongoid.yml #{current_release}/config &&
    ln -s #{shared_path}/config/config.god #{current_release}/config &&
    ln -s #{shared_path}/config/unicorn.conf.rb #{current_release}/config
  BASH
end

namespace :deploy do
  task :default do
    update
    restart
  end

  desc 'Restart god'
  task :restart do
    run 'sudo god restart unicorn'
  end

  desc 'Start god'
  task :start, roles: :app do
    run 'sudo /etc/init.d/god start'
  end

  desc 'Stop god'
  task :stop, roles: :app do
    run 'sudo /etc/init.d/god stop'
  end
end
