require "bundler/capistrano"

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

  task :remove_htaccess, :roles => :app do
    run "rm -f #{release_path}/public/.htaccess"
  end
end

task :copy_production_database_configuration do
  run "cp #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end


namespace :bundler do
  #en attendant de bundler les gems directement dans le systeme (nécessite sudo actuellement)
  task :bundle_new_release, :roles => :app do
    run "bundle install --deployment"
    #crée un lien symbolique de shared/bundle current/vendor/bundle
#    shared_dir = File.join(shared_path, 'bundle')
#    run "mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_path}/vendor/bundle"
#    run "cd #{release_path} && bundle install vendor/bundle --without development"
  end
end

namespace :compass do
  task :compile, :roles => :app do
    run "cd #{release_path} && bundle exec compass compile -e production --force"
  end
end

after "deploy:update_code", :copy_production_database_configuration
after "deploy:update_code", "deploy:remove_htaccess"
after "deploy:remove_htaccess", 'bundler:bundle_new_release'
after 'bundler:bundle_new_release', 'compass:compile'

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"



