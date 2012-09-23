# coding: utf-8
#move to ruser helper , why not recoginize
if false
module Ruser::LocationsHelper
  def location_name_tag(location,options = {})
    return "" if location.blank?
    name = location.is_a?(String) == true ? location : location.name
    result = link_to(name, location_users_path(name))
  end
end
end