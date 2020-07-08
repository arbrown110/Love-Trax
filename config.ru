require_relative './config/environment'

#use Rack::MethodOverride
use TraxController
use UsersController
run ApplicationController

