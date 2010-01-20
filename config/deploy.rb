set :application, "eJosh"
set :repository,  "git://github.com/joshsoftware/ejosh.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.1.100" # Your HTTP server, Apache/etc
role :app, "192.168.1.100", :mongrel => true, :sphinx => true, :memcached => true
#role :app, "192.168.1.100:10000"   # This may be the same as your `Web` server
role :db,  "192.168.1.100", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/home/shailesh/eJosh_latest"
set :use_sudo, false
set :rails_env, "production"
set :git_enable_submodules, 1

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do
     run "#{try_sudo} service nginx reload"
   end

   task :stop do
   end

   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end
