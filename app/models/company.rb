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

  #
  # self.regist
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def self.regist(name, description, password, email, password_confirm)
    company_data = Company.new
    if password == password_confirm && !password.blank?
      company_data.name = name
      company_data.description = description
      company_data.email = email
      company_data.password = password
      if company_data.save
        return true
      end
      return false
    end
   return false
  end

  #
  # updated
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def self.updated(company_id, name, description, password, email, email_confirm)
    company = Company.where(id: company_id).first
    if password == password_confirm && !password.blank?
      company.name = name
      company.description = description
      company.email = email
      company.password = password
      if company.save
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
