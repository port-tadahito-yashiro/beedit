class SuperController < ApplicationController

  def index
  end

  def dashboard
  end

  def login
  end

  def logout
  end

  def project_list
    @projects = Project.all
  end

  def project_add
  end

  def project_edit
  end

  def project_delete
  end

  def project_delete_list
  end

  def project_delete_restore
  end

  def project_graph
  end

  def company_list
  end

  def company_add
  end

  def company_edit
  end

  def company_delete
  end

end
