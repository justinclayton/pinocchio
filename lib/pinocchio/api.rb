# pinocchio/api
require 'cucumber'

require 'pinocchio/api/config'
require 'pinocchio/api/vagrant'

# by default, vagrant looks in your spec/fixtures set up by puppetlabs_spec_helper
MODULE_PATH            = File.join(Dir.pwd, 'spec', 'fixtures', 'modules')
MANIFESTS_PATH         = File.join(Dir.pwd, 'spec', 'fixtures', 'manifests')
MANIFEST_FILE          = 'pinocchio.pp'
TIMEOUT_SECONDS        = 300
## XXX: write code to allow for array here
BOXES                  = Pinocchio.import_boxes
EXPOSED_PORTS          = []