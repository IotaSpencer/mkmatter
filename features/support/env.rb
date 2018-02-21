require 'aruba/cucumber'
require 'aruba/in_process'
require 'mkmatter/cli/runner'

Aruba::Processes::InProcess.main_class = Mkmatter::App::Runner
Aruba.process                          = Aruba::Processes::InProcess