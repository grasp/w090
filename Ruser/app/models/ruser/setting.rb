class Ruser::Setting < Settingslogic
  source "#{Ruser::Engine.root}/config/ruser.yml"
  namespace Rails.env# is this correct?
# namespace Ruser::Engine.env
end
