require "bundler/capistrano"

django = "django.webflows.fr"

set :application, "alvaro"
set :repository,  "git@github.com:itkin/alvarocanovas.git"

set :scm, :git
set :deploy_to, "~/alvaro"

set :use_sudo, false

set :user, "rails"
set :password,  Proc.new {Capistrano::CLI.password_prompt("Rails user password on django : ")}
#set :scm_passphrase, "rVmEKX42912"#Proc.new {Capistrano::CLI.password_prompt("Rails user password on django : ")}

set :branch, "master"

role :web, django
role :app, django
role :db,  django, :primary => true

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

task :copy_production_database_configuration do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

namespace :compass do
  task :compile, :roles => :app do
    run "cd #{release_path} && bundle exec compass compile -e production --force"
  end
end

after "deploy:update_code", :copy_production_database_configuration
after "bundle:install", 'compass:compile'


after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"



