require 'digest/sha1'

class Super < ActiveRecord::Base
  before_save do
    # salt値の生成
    self.salt = Super.new_salt
    self.password = Super.crypt_password(self.password, self.salt)
    self.created_at = Time.now
    self.created_time = Time.now.to_i
    self.created_user = 1
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
    self.updated_user = 1
  end

  before_update do
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
  end

  def self.authenticate(email, password)
    auth = Super.where(email: email, password: Digest::SHA1.hexdigest("#{Rails.application.secrets[:salt]}#{password}").first)
    return auth
  end

  private

  #
  # self.crypt_password
  # Author kazuki.yamaguchi
  # Created
  # パスワードを暗号化する
  def self.crypt_password(password, salt)
    Digest::SHA1.hexdigest(salt + password)
  end

  #
  # self.new_salt
  # Author kazuki.yamaguchi
  # Created
  # パスワード暗号化のためのsalt生成
  def self.new_salt
    s = rand.to_s.tr('+', '.')
    s[0, if s.size > 32 then 32 else s.size end]
  end
end
