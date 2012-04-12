class Rforum::Setting < Settingslogic
  source "#{Rforum::Engine.root}/config/rforum.yml"
  namespace Rails.env# is this correct?

end
