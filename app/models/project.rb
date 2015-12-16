require 'csv'

class Project < ActiveRecord::Base

  has_many :events
  has_many :tasks

  #paginates_per 5

  before_save do
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


end
