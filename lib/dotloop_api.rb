# vendors
require 'plissken'
require 'httparty'
require 'virtus'

# helpers w/o dependencies
require 'dotloop_api/version'
require 'dotloop_api/exceptions'
require 'dotloop_api/end_points/param_helper'
require 'dotloop_api/end_points/model_builder'
require 'dotloop_api/end_points/base'
require 'dotloop_api/end_points/batch'

# dotloop models
require 'dotloop_api/models/config'
require 'dotloop_api/models/contact'
require 'dotloop_api/models/profile'
require 'dotloop_api/models/profile/loop'
require 'dotloop_api/models/profile/loop/activity'
require 'dotloop_api/models/profile/loop/detail'
require 'dotloop_api/models/profile/loop/folder'
require 'dotloop_api/models/profile/loop/folder/document'
require 'dotloop_api/models/profile/loop/tasklist'
require 'dotloop_api/models/profile/loop/tasklist/task'
require 'dotloop_api/models/profile/loop_template'

# auth classes
require 'dotloop_api/auth'
require 'dotloop_api/client'

# dotloop endpoints
require 'dotloop_api/end_points/account'
require 'dotloop_api/end_points/contact'
require 'dotloop_api/end_points/profile'
require 'dotloop_api/end_points/loop'
require 'dotloop_api/end_points/detail'
require 'dotloop_api/end_points/activity'
require 'dotloop_api/end_points/task'
require 'dotloop_api/end_points/loop_template'
require 'dotloop_api/end_points/task_list'
require 'dotloop_api/end_points/document'
require 'dotloop_api/end_points/folder'
require 'dotloop_api/end_points/participant'

module DotloopApi
  # Your code goes here...
end
