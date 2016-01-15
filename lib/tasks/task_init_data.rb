class TaskInitData


  def self.init_all
    # bundle exec rails runner TaskInitData::init_all 実行
    self.department
    self.role
  end

  #rails runner Department::department　実行
  def self.department
    Department.create(:name => '営業部',:description => 'テスト1')
    Department.create(:name => 'オペレーション部',:description => 'テスト2')
    Department.create(:name => '事業開発部',:description => 'テスト3')
    Department.create(:name => 'Web開発事業部',:description => 'テスト4')
    Department.create(:name => '総務・会計部',:description => 'テスト5')
  end

  def self.role
    Role.create(name: 'super', description: 'd1')
    Role.create(name: 'development', description: 'd2')
    Role.create(name: 'operation', description: 'd3')
  end

end
