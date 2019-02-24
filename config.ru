require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end


use SetupsController
use HardwaresController
use ResourcesController
use UsersController
run ApplicationController
