require 'digest/sha1'

class Admin < ActiveRecord::Base

  has_one :department
  has_one :role
  has_many :tasks

  paginates_per 5

  before_save do
    self.salt         = Admin.new_salt
    self.password     = Admin.crypt_password(self.password, self.salt)
    self.created_at   = Time.now
    self.created_time = Time.now.to_i
    self.created_user = 1
    self.updated_at   = Time.now
    self.updated_time = Time.now.to_i
    self.updated_user = 1
  end

  before_update do
    self.salt         = Admin.new_salt
    self.password     = Admin.crypt_password(self.password, self.salt)
    self.updated_at   = Time.now
    self.updated_time = Time.now.to_i
  end

  #
  # authenticate
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def self.authenticate(email, password)
    # パラメータ:emailを持つUserが存在しない場合nilを返す
    return if !(admin = Admin.where(email: email, deleted_at: nil).first)
    saltpass = admin.salt + password
    sha1p = Digest::SHA1.hexdigest(saltpass)
    return admin if admin.deleted_at.blank? && sha1p == admin.password
  end

  #
  # regist
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  #
  def self.regist(params)
    admin = Admin.new
    if params[:password] == params[:password_confirm] && !params[:password].blank? ||
       !params[:name].blank? ||
       !params[:email].blank?
      admin.name          = params[:name]
      admin.department_id = params[:department].to_i
      admin.role_id       = params[:role].to_i
      admin.email         = params[:email]
      admin.password      = params[:password]
      if admin.save
        return true
      end
      return false
    end
   return false
  end

  def self.updated(params)
    admin = Admin.where(id: params[:id]).first
    if params[:password] == params[:password_confirm] && !params[:password].blank? ||
       !params[:name].blank? ||
       !params[:email].blank?
      admin.name          = params[:name]
      admin.department_id = params[:department].to_i
      admin.role_id       = params[:role].to_i
      admin.email         = params[:email]
      admin.password      = params[:password]
      if admin.save
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
