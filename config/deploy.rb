set :application, 'trackr'
set :repo_url, 'git@github.com:dnath/trackr.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/home/ubuntu'
set :user, %{ubuntu}
set :use_sudo, false
set :latest_release_directory, File.join(fetch(:deploy_to), 'current')

# set :scm, :git

# set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}



namespace :deploy do

  desc 'Create database'
    task :create do
      on roles(:db) do
        run "cd #{current_path} && bundle exec rake db:create RAILS_ENV=staging --trace"
      end
    end        

 desc 'Migrate database'
    task :migrate do
      run "cd #{current_path} && bundle exec rake db:migrate RAILS_ENV=staging --trace"
    end  

   desc 'Load seed'
    task :seed do
      run "cd #{current_path} && bundle exec rake db:seed RAILS_ENV=staging --trace"
    end  

  desc 'Provision env before assets:precompile'
  task :fix_bug_env do
    set :rails_env, (fetch(:rails_env) || fetch(:stage))
  end

  before "deploy:assets:precompile", "deploy:create"

  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo /etc/init.d/nginx restart #restart nginx"
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
