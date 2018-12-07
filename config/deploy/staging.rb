server '159.65.141.125',
  user: 'staging',
  roles: %w{app db},
  ssh_options: {
    auth_methods: %w(publickey password),
    port: 22
  }

set :default_env, {
  'MAX_THREADS' => 4,
  'WEB_CONCURRENCY' => 1,
  'RAILS_MASTER_KEY' => '5df1b37d3e5c552f166589bd83d94bd2'
}

set :branch, ENV['branch'] || 'develop'
set :rvm_roles, [:app, :db]
set :rvm_ruby_version, '2.5.1@lifevitae'
