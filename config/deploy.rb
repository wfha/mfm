require "bundler/capistrano"
require "rvm/capistrano"

server "107.22.220.9", :web, :app, :db, primary: true
ssh_options[:forward_agent] = true
ssh_options[:keys] = ["#{ENV['HOME']}/.ec2/gsg-keypair"]
default_run_options[:pty] = true

set :application, "mfm"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:wfha/#{application}.git"
set :branch, "master"

# Fix sh bundle not found problem
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user  # Don't use system-wide RVM

# Create symbolic links for capistrano
set :shared_children, shared_children + %w{public/uploads}

after "deploy", "deploy:cleanup" # keep only the last 5 releases

# Added for delayed job
# ======================================
require "delayed/recipes"

set :rails_env, "production"

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/app_config.example.yml"), "#{shared_path}/config/app_config.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end