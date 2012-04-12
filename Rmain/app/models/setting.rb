class Setting < Settingslogic
  source "#{Rails.root}/config/rmain.yml"
  namespace Rails.env# is this correct?
end
