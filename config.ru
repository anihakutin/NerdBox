require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

run ApplicationController
use SetupsController
use HardwaresController
use ResourcesController
use UsersController
use UseRsController
