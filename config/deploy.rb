django = "django.webflows.fr"

set :application, "alvaro"
set :repository,  "git@github.com:itkin/alvarocanovas.git"

set :scm, :git
set :deploy_to, "~/alvaro"

set :use_sudo, false

set :user, "rails"
set :scm_passphrase, Capistrano::CLI.password_prompt("Rails user password on django : ")

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

after "deploy:update_code", :copy_production_database_configuration

