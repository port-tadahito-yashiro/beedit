class Beedit < ActiveRecord::Base

  establish_connection(:beedit)


  # DB格納前のフック
  # タイムスタンプの生成
  before_create do
    self.created_at = Time.now
    self.created_time = Time.now.to_i
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
  end

  # saltと暗号化されたパスワードを生成
  before_update do
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
  end


end
