RSpec.configure do |config|
  # additional factory_girl configuration
  config.include FactoryGirl::Syntax::Methods

  DatabaseCleaner.strategy = :deletion

  config.before(:all) do
    begin

      DatabaseCleaner.start
      # FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end