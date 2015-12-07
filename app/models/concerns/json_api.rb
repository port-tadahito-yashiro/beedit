
#
# Json_api
# Author kazuki.yamaguchi
# Created 2015/12/03
#
module Json_api

  #
  # self.api(open_url,json_params)
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  # apiを叩く処理
  def self.get_json(open_url,json_params)
    #APIを叩く処理
    uri = URI.parse(open_url)
    http = Net::HTTP.new(uri.host,uri.port)
    json = http.post(uri.path, json_params)
    return json
  end

  #
  # self.get_json_result(json)
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  # 処理の確認
  def self.get_json_result(json)

    #成功のステータスが返ってきた時の処理
    if json.code == "200" then
      p "~~~~~~~~"
      p json.body
      return admin = ActiveSupport::JSON.decode(json.body)
    end

    #失敗のステータスが返ってきた時の処理
    if json.code == "400" then
      return {"error" => "プログラムに問題があります"}
    end
  end

end
