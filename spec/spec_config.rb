require "rubygems"
require "sequel"
require "database_cleaner"
require "factory_girl"

# using the sqlite memory database
Sequel::Model.db = Sequel.sqlite(':memory:')

# migrate and require all data models
Sequel.extension :migration, :core_extensions
Sequel::Migrator.run(Sequel::Model.db, File.expand_path("#{File.expand_path(File.dirname(__FILE__))}/../lib/bizflow/migrations"), :use_transactions=>false)

Dir["#{File.dirname(__FILE__)}/../lib/bizflow/data_model/*.rb"].each { |path| require_relative path }

FactoryGirl.find_definitions

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do

    # set database clean type
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)

    # lint
    # DatabaseCleaner.start
    # FactoryGirl.lint
    # DatabaseCleaner.clean
    
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
