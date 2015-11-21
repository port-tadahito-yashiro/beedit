Rails.application.routes.draw do

  # ログイン画面
  root 'super#index'

  # ダッシュボード
  match '/super/dashboard'     => 'super#dashboard', :via => [:get]

  # イベント周り
  #match '/events', :controller => 'events', :action => ''
  resources :event

  #プロジェクト
  match '/super/project/list'                => 'super#project_list',:via => [:get]
  match '/super/project/add'                 => 'super#project_add',:via => [:get, :post]
  match '/super/project/edit/:id'            => 'super#project_edit',:via => [:get, :post]
  match '/super/project/delete/:id'          => 'super#project_delete',:via => [:get, :post]
  match '/super/project/delete/list'         => 'super#project_delete_list',:via => [:get, :post]
  match '/super/project/delete/restore/:id'  => 'super#project_delete_restore',:via => [:get, :post]
  match '/super/project/graph/:id'           => 'super#project_graph',:via => [:get]

  #企業
  match '/super/company/list'                => 'super#company_list',:via => [:get]
  match '/super/company/add'                 => 'super#company_add',:via => [:get, :post]
  match '/super/company/edit/'               => 'super#company_edit',:via => [:get, :post]
  match '/super/company/delete'              => 'super#company_delete',:via => [:get, :post]

  #タグ
  match '/super/tag/list'                     => 'super#tag_list', :via => [:get]
  match '/super/tag/add'                      => 'super#tag_add',  :via => [:get, :post]
  match '/super/tag/edit'                     => 'super#tag_edit',  :via => [:get, :post]
  match '/super/tag/delete'                   => 'super#tag_delete',  :via => [:get, :post]

  #管理ユーザー
  match '/super/user/list'                    => 'super#user_list', :via => [:get]
  match '/super/user/add'                     => 'super#user_add', :via => [:get]
  match '/super/user/edit'                    => 'super#user_edit', :via => [:get]
  match '/super/user/delete'                  => 'super#user_delete', :via => [:get]



end
