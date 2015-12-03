include Json_api

#
# Beedit_api
# Author kazuki.yamaguchi
# Created 2015/12/03
#
module Beedit_api

  #
  # self.api(open_url,json_params)
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def self.api(open_url,json_params)
      json = Json_api.get_json(open_url,json_params)
      result = Json_api.get_json_result(json)
      return result
  end
end
