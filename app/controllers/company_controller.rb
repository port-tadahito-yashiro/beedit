class CompanyController < ApplicationController
  # 未ログインの場合はログイン画面へ移動
  before_action :authenticate

  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def list
    @companies = Company.where(deleted_at: nil).order('id DESC').page(params[:page]).per(15)
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def add
    if request.post?
      if Company.regist(params)
        flash[:notice] = '新規 企業情報を作成しました'
        redirect_to(url_for({ controller: 'super', action: 'dashboard' }))
      else
        flash[:error] = '新規 企業情報作成に失敗しました'
        redirect_to(url_for({ controller: 'company', action: 'add' }))
      end
    end
  end

  #
  # edit
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def edit
    @projects = Project.where(company_id: params[:id]).order('id DESC').page(params[:page]).per(10)
    @company = Company.where(id: params[:id]).first
    if request.post?
      if Company.updated(params)
        flash[:notice] = '企業情報を編集しました'
        redirect_to(url_for({ controller: 'super', action: 'dashboard' }))
      else
        flash[:error] = '企業情報の編集に失敗しました'
        redirect_to(url_for({ controller: 'company', action: 'edit', id: params[:id]}))
      end
    end
  end

  #
  # delete
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def delete
    company = Company.where(id: params[:id]).first
    company.deleted_at = Time.now
    company.deleted_time = Time.now.to_i
    company.deleted_user = 1
    if company.save
      flash[:notice] = '企業情報を削除しました'
      render json: { success: true }
    else
      flash[:error] = '企業情報の削除に失敗しました'
      render json: { success: false }
    end
  end

end
