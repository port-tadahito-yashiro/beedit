require 'digest/sha1'

class Company < ActiveRecord::Base

  before_save do

  self.salt = Company.new_salt
  self.password = Company.crypt_password(self.password, self.salt)

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


  def self.regist(name,description,password,email, password_confirm)
    company_data = Company.new
    p password
    if password == password_confirm and !password.blank?
      company_data.name = name
      company_data.description = description
      company_data.email = email
      company_data.password = password
      p company_data
      if company_data.save then
        return true
      end
      return false
    end
   return false
  end


  private
  #
  # self.crypt_password
  # Author
  # Created
  # パスワードを暗号化する
  def self.crypt_password(password, salt)
    Digest::SHA1.hexdigest(salt + password)
  end

  #
  # self.new_salt
  # Author
  # Created
  # パスワード暗号化のためのsalt生成
  def self.new_salt
    s = rand.to_s.tr('+', '.')
    s[0, if s.size > 32 then 32 else s.size end]
  end



end
