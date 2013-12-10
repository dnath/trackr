set :stage, :production
set :rails_env, 'production'

set :rvm_type, :user #Tell rvm to look in ~/.rvm
set :rvm_ruby_version, '2.0.0-p247'

set :server_name1, %w{ec2-54-196-21-103.compute-1.amazonaws.com}
set :server_name2, %w{ec2-54-227-7-255.compute-1.amazonaws.com} #Trackr 1
set :db_server, %w{ec2-54-232-134-61.sa-east-1.compute.amazonaws.com}
# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.

role :web, "ec2-54-196-21-103.compute-1.amazonaws.com"
role :web, "ec2-54-227-7-255.compute-1.amazonaws.com"
role :app, "ec2-54-196-21-103.compute-1.amazonaws.com" #fetch(:server_name1), fetch(:server_name2)# Needed for preparing something I forgot what
role :app, "ec2-54-227-7-255.compute-1.amazonaws.com"

# #Sao Paulo
# #role :web, "ec2-54-232-170-169.sa-east-1.compute.amazonaws.com"
# #role :web, "ec2-54-232-172-48.sa-east-1.compute.amazonaws.com"
# role :web, "ec2-54-232-165-128.sa-east-1.compute.amazonaws.com" #works
# # role :web, "ec2-54-232-33-156.sa-east-1.compute.amazonaws.com"
# #role :web, "ec2-54-207-141-135.sa-east-1.compute.amazonaws.com"
# role :web, "ec2-54-207-147-221.sa-east-1.compute.amazonaws.com" #works
# # role :web, "ec2-54-207-138-123.sa-east-1.compute.amazonaws.com"
# # role :web, "ec2-54-232-162-254.sa-east-1.compute.amazonaws.com"
 # role :web, "ec2-177-71-156-33.sa-east-1.compute.amazonaws.com" #works
# # role :web, "ec2-54-232-11-184.sa-east-1.compute.amazonaws.com"
# # role :web, "ec2-54-232-173-235.sa-east-1.compute.amazonaws.com"
 # role :web, "ec2-54-207-164-242.sa-east-1.compute.amazonaws.com" #works
 # # role :web, "ec2-54-207-150-172.sa-east-1.compute.amazonaws.com" #works
# # # role :web, "ec2-54-232-160-78.sa-east-1.compute.amazonaws.com"
# # role :web, "ec2-54-207-160-245.sa-east-1.compute.amazonaws.com" #works
# # role :web, "ec2-177-71-225-175.sa-east-1.compute.amazonaws.com" #works
# 
# 
# #role :app, "ec2-54-232-170-169.sa-east-1.compute.amazonaws.com"
# #role :app, "ec2-54-232-172-48.sa-east-1.compute.amazonaws.com"
# role :app, "ec2-54-232-165-128.sa-east-1.compute.amazonaws.com" #works
# # role :app, "ec2-54-232-33-156.sa-east-1.compute.amazonaws.com"
# # role :app, "ec2-54-207-141-135.sa-east-1.compute.amazonaws.com"
# role :app, "ec2-54-207-147-221.sa-east-1.compute.amazonaws.com" #works
# # role :app, "ec2-54-207-138-123.sa-east-1.compute.amazonaws.com"
# # role :app, "ec2-54-232-162-254.sa-east-1.compute.amazonaws.com"
# #role :app, "ec2-54-207-155-88.sa-east-1.compute.amazonaws.com"
# # role :app, "ec2-54-232-11-184.sa-east-1.compute.amazonaws.com"
# role :app, "ec2-177-71-156-33.sa-east-1.compute.amazonaws.com"
# role :app, "ec2-54-207-164-242.sa-east-1.compute.amazonaws.com" #works
# # role :app, "ec2-54-207-150-172.sa-east-1.compute.amazonaws.com" #works
# # # role :app, "ec2-54-232-160-78.sa-east-1.compute.amazonaws.com"
# # role :app, "ec2-54-207-160-245.sa-east-1.compute.amazonaws.com" #works
# # role :app, "ec2-177-71-225-175.sa-east-1.compute.amazonaws.com"

#role :db, fetch(:db_server) # Needed for migration
#role :all, [fetch(:server_name1), fetch(:server_name2), fetch(:db_server)]# This doesn't work completely yet, hence the above 3 specifications

set :ssh_options, {
    user: %{ubuntu},                # The user we want to log in as
    keys: %w{/home/divya/.ssh/Tracker.pem
      }, # Your .pem file
    forward_agent: true,          # In order for our EC2 instance to be able to access Github via ssh we need to forward our local ssh agent (since we have set up Github to accept that)
    auth_methods: %w(publickey)   # We are using ssh with .pem files
}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
#server 'example.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :production)
