# Skip database connection during assets precompile
if defined?(Rails) && Rails.env.production?
  if ARGV.any? { |arg| arg == 'assets:precompile' }
    Rails.application.configure do
      config.assets.initialize_on_precompile = false
    end
    
    # Skip Active Record initialization if DATABASE_URL is not available
    if ENV['DATABASE_URL'].blank?
      ActiveRecord::Base.logger = nil
      ActiveRecord::Base.establish_connection(
        adapter: 'postgresql',
        database: 'dummy',
        username: 'dummy',
        password: 'dummy',
        host: 'localhost'
      )
    end
  end
end