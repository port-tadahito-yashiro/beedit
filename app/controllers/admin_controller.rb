class AdminController < ApplicationController
  # 未ログインの場合はログイン画面へ移動
  # before_action :authenticate

  #
  # list
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def list
    @admins = Admin.where(deleted_at: nil).order('id DESC').page(params[:page]).per(15)
  end

  #
  # add
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def add
    @departments = Department.all
    if request.post?
      if Admin.regist(params)
        flash[:notice] = '新規ユーザーを作成しました'
        redirect_to(url_for({ controller: 'super', action: 'dashboard' }))
      else
        flash[:error] = '新規ユーザー作成に失敗しました'
        redirect_to(url_for({ controller: 'admin', action: 'add' }))
      end
    end
  end

  #
  # edit
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def edit
    @admin = Admin.where(id: params[:id]).first
    @departments = Department.all
    if request.post?
      if Admin.updated(params)
        flash[:notice] = 'ユーザー情報を編集しました'
        redirect_to(url_for({ controller: 'super', action: 'dashboard' }))
      else
        flash[:error] = 'ユーザ-の情報編集に失敗しました'
        redirect_to(url_for({ controller: 'admin', action: 'edit', id: params[:id]}))
      end
    end
  end

  #
  # delete
  # Author kazuki.yamaguchi
  # Created 2015/12/03
  #
  def delete
    admin = Admin.where(id: params[:id]).first
    admin.deleted_at = Time.now
    admin.deleted_time = Time.now.to_i
    admin.deleted_user = 1
    if admin.save
      flash[:notice] = 'ユーザー情報を削除しました'
      render json: { success: true }
    else
      flash[:error] = 'ユーザー情報の削除に失敗しました'
      render json: { success: false }
    end
  end
end
