require 'csv'
class Project < ActiveRecord::Base

  has_many :events
  has_many :tasks
  # paginates_per 5
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

  def self.regist(params)
    project = Project.new
    project.sales_user_id      = params[:sales].to_i
    project.company_id         = params[:company].to_i
    project.name               = params[:name]
    project.table_name         = params[:table_name]
    project.url                = params[:url]
    project.page_type          = 1
    project.title              = params[:title]
    project.description        = params[:description]
    project.ogp_description    = params[:ogp_description]
    project.start_at           = params[:start_at]
    project.finish_at          = params[:finish_at]
    project.domain_name        = params[:domain_name]
    project.domain_deadline_at = params[:domain_deadline_at]
    project.ssl_deadline_at    = params[:ssl_deadline_at]
    if project.save
      return project
    else
      return false
    end
  end

  def self.update(params, project_id)
    project = Project.where(id: project_id).first
    project.sales_user_id      = params[:sales].to_i
    project.company_id         = params[:company].to_i
    project.name               = params[:name]
    project.table_name         = params[:table_name]
    project.url                = params[:url]
    project.page_type          = 1
    project.title              = params[:title]
    project.description        = params[:description]
    project.ogp_description    = params[:ogp_description]
    project.start_at           = params[:start_at]
    project.finish_at          = params[:finish_at]
    project.domain_name        = params[:domain_name]
    project.domain_deadline_at = params[:domain_deadline_at]
    project.ssl_deadline_at    = params[:ssl_deadline_at]
    if project.save
      return true
    else
      return false
    end
  end
end
