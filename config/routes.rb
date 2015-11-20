Rails.application.routes.draw do

  # ログイン画面
  root 'super#index'

  # ダッシュボード
  match '/super/dashboard',     :controller => 'super', :action => 'dashboard', :via => [:get]

  # イベント周り
  #match '/events', :controller => 'events', :action => ''
  resources :event

  #プロジェクト
  match '/super/project/list',    :controller => 'super', :action => 'project_list',:via => [:get]
  match '/super/project/add',    :controller => 'super', :action => 'project_add',:via => [:get, :post]
  match '/super/project/edit',    :controller => 'super', :action => 'project_edit',:via => [:get, :post]
  match '/super/project/delete',    :controller => 'super', :action => 'project_delete',:via => [:get, :post]

  #企業
  match '/super/company/list',    :controller => 'super', :action => 'company_list',:via => [:get]
  match '/super/company/add',    :controller => 'super', :action => 'company_add',:via => [:get, :post]
  match '/super/company/edit',    :controller => 'super', :action => 'company_edit',:via => [:get, :post]
  match '/super/company/delete',    :controller => 'super', :action => 'company_delete',:via => [:get, :post]

  #タグ
  match '/super/tag/list',    :controller => 'super', :action => 'tag_list', :via => [:get]
  match '/super/tag/add',     :controller => 'super', :action => 'tag_add',  :via => [:get, :post]
  match '/super/tag/edit',     :controller => 'super', :action => 'tag_edit',  :via => [:get, :post]
  match '/super/tag/delete',     :controller => 'super', :action => 'tag_delete',  :via => [:get, :post]

  #管理ユーザー
  match '/super/user/list',     :controller => 'super', :action => 'user_list', :via => [:get]
  match '/super/user/add',     :controller => 'super', :action => 'user_add', :via => [:get]
  match '/super/user/edit',     :controller => 'super', :action => 'user_edit', :via => [:get]
  match '/super/user/delete',     :controller => 'super', :action => 'user_delete', :via => [:get]



end
