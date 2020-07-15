require_relative './config/environment'

use Rack::MethodOverride
use TraxesController
use UsersController
run ApplicationController

