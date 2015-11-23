require 'digest/sha1'

class Admin < ActiveRecord::Base

  before_save do

  self.salt = Admin.new_salt
  self.password = Admin.crypt_password(self.password, self.salt)

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

 def self.regist(name,email, password, password_confirm)
    admin = self.new
    if password == password_confirm and !password.blank?
      admin.name = name
      admin.email = email
      admin.password = password
      if admin.save then
        return true
      end
      return false
    end
   return false
 end

  private
  #
  # self.crypt_password
  # Author masaki.nagaishi
  # Created 2015/02/13
  # パスワードを暗号化する
  def self.crypt_password(password, salt)
    Digest::SHA1.hexdigest(salt + password)
  end

  #
  # self.new_salt
  # Author masaki.nagaishi
  # Created 2015/02/13
  # パスワード暗号化のためのsalt生成
  def self.new_salt
    s = rand.to_s.tr('+', '.')
    s[0, if s.size > 32 then 32 else s.size end]
  end


end
