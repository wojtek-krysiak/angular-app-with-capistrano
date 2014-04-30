# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'angular-capistrano'
set :repo_url, 'git@github.com:wojtek-krysiak/angular-capistrano.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/angular_capistran'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{node_modules app/bower_components}

set :default_env, { 
  path: ["/usr/local/rbenv/shims",
    "#{shared_path}/node_modules/bower/bin", 
    "#{shared_path}/node_modules/grunt-cli/bin",
    "/usr/local/rbenv/versions/#{fetch(:rbenv_ruby)}/bin",
    "$PATH"].join(":")
}

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      
    end
  end

  task :bower_and_npm_install do 
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do 
        execute :npm, "install"
        execute :bower, "install"
      end
    end
  end

  task :build do 
    on roles(:app), in: :sequence, wait: 5 do 
      within release_path do 
        execute :grunt, "build"
      end
    end
  end
  
  after :bower_and_npm_install, :build
  after :publishing, :restart
  after :published, :bower_and_npm_install
end