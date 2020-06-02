#require 'bundler'

#Bundler.require

#ActiveRecord::Base.establish_connection(
##  :database => "db/development.sqlite"
#)
#require_all 'app'

ENV['SINATRA_ENV'] ||= "development"

require 'pry'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

def fi_check_migration
  begin
    ActiveRecord::Migration.check_pending!
  rescue ActiveRecord::PendingMigrationError
    raise ActiveRecord::PendingMigrationError.new "Migrations are pending.\nTo resolve this issue, run: \nrake db:migrate SINATRA_ENV=#{ENV['SINATRA_ENV']}"
  end
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
