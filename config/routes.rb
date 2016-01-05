Rails.application.routes.draw do

  # ログイン画面
  #match '/super/login' => 'super#index', :via => [:get, :post]
  root 'super#index'
  match '/super/logout' => 'super#logout', :via => [:get, :post]

  # ダッシュボード
  match '/super/dashboard'     => 'super#dashboard', :via => [:get]

  # イベント周り
  match '/super/events'   => 'event#create', :via => [:get, :post]
  match '/super/events/:id'   => 'event#update', :via => [:put, :post]
  match '/super/events/delete/:id'   => 'event#delete', :via => [:get, :post]
  # フォーム取得
  match '/project/getform/task'     => 'project#get_form', :via => [:get]


  #タスク管理
  match '/super/task/list'                   => 'task#list',:via => [:get]
  match '/super/task/add'                    => 'task#add',:via => [:get,:post]
  match '/super/task/edit'                   => 'task#edit',:via => [:get,:post]
  match '/super/task/delete/:id'             => 'task#delete',:via => [:get,:post]
  match '/super/task/finish/:id'             => 'task#finish',:via => [:get,:post]

  #プロジェクト
  match '/super/project/list'                => 'project#list',:via => [:get]
  match '/super/project/add'                 => 'project#add',:via => [:get, :post]
  match '/super/project/edit/:id'            => 'project#edit',:via => [:get, :post]
  match '/super/project/delete/:id'          => 'project#delete',:via => [:get, :post]
  match '/super/project/delete/list'         => 'project#delete_list',:via => [:get, :post]
  match '/super/project/delete/restore/:id'  => 'project#delete_restore',:via => [:get, :post]
  match '/super/project/graph/:id'           => 'project#graph',:via => [:get]
  match '/super/project/user/:id'            => 'project#user',:via => [:get,:post]

  #企業
  match '/super/company/list'                => 'company#list',:via => [:get]
  match '/super/company/add'                 => 'company#add',:via => [:get, :post]
  match '/super/company/edit/:id'            => 'company#edit',:via => [:get, :post]
  match '/super/company/delete/:id'          => 'company#delete',:via => [:get, :post]

  #タグ
  match '/super/tag/list'                     => 'tag#list', :via => [:get]
  match '/super/tag/add'                      => 'tag#add',  :via => [:get, :post]
  match '/super/tag/edit'                     => 'tag#edit',  :via => [:get, :post]
  match '/super/tag/delete'                   => 'tag#delete',  :via => [:get, :post]

  #管理ユーザー
  match '/super/admin/list'                    => 'admin#list', :via => [:get]
  match '/super/admin/add'                     => 'admin#add', :via => [:get,:post]
  match '/super/admin/edit/:id'                => 'admin#edit', :via => [:get,:post]
  match '/super/admin/delete/:id'              => 'admin#delete', :via => [:get, :post]

  #管理ユーザー
  #match '/super/admin/list'                   => 'admin#admin_list', :via => [:get]


end
