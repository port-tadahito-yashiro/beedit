require 'digest/sha1'

class Admin < ActiveRecord::Base

  has_one :department
  has_many :tasks

  paginates_per 5

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
    self.salt = Admin.new_salt
    self.password = Admin.crypt_password(self.password, self.salt)
    self.updated_at = Time.now
    self.updated_time = Time.now.to_i
  end


  #
  # authenticate
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def self.authenticate(email,password)
    # パラメータ:emailを持つUserが存在しない場合nilを返す
    return if !(admin = Admin.where(:email => email,:deleted_at => nil).first)
    saltpass = admin.salt + password
    p saltpass
    sha1p = Digest::SHA1.hexdigest(saltpass)

    p sha1p
    return admin if admin.deleted_at.blank? && sha1p == admin.password
  end



  #
  # regist
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def self.regist(department,name,email,password,password_confirm)
    admin = Admin.new
    if password == password_confirm and !password.blank? ||
       !name.blank? ||
       !email.blank?
      admin.name = name
      admin.department_id = department.to_i
      admin.email = email
      admin.password = password
      if admin.save then
        return true
      end
      return false
    end
   return false
  end

  def self.updated(admin_id,department,name,email,password,password_confirm)
    admin = Admin.where(:id => admin_id).first

    if password == password_confirm and !password.blank? ||
       !name.blank? ||
       !email.blank?
      admin.name = name
      admin.department_id = department.to_i
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
