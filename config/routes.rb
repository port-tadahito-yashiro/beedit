Rails.application.routes.draw do

  # ログイン画面
  root 'super#index'

  # ダッシュボード
  match '/super/dashboard'     => 'super#dashboard', :via => [:get]

  # イベント周り
  #match '/events', :controller => 'events', :action => ''
  #resources :event

  match '/super/events'   => 'event#create', :via => [:get, :post]

  #タスク管理
  match '/super/task/lsit'                   => 'super#task_list',:via => [:get]
  match '/super/task/add'                   => 'super#task_add',:via => [:get,:post]
  match '/super/task/edit'                   => 'super#task_edit',:via => [:get,:post]
  match '/super/task/delete'                   => 'super#task_delete',:via => [:get,:post]

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
  match '/super/admin/list'                    => 'super#admin_list', :via => [:get]
  match '/super/admin/add'                     => 'super#admin_add', :via => [:get,:post]
  match '/super/admin/edit'                    => 'super#admin_edit', :via => [:get]
  match '/super/admin/delete'                  => 'super#admin_delete', :via => [:get]

  #管理ユーザー
  #match '/super/admin/list'                   => 'admin#admin_list', :via => [:get]


end
