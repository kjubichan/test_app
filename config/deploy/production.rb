set :stage, :production
set :branch, "master"
set :domain, "novostroi.biz"

server "78.47.164.40", roles: %w{web app db}, user: 'deployer', primary: true
set :deploy_to, "/home/#{ fetch( :deploy_user ) }/apps/#{ fetch( :application )}"
set :rails_env, :production

set :bundle_binstubs, nil
