class Department

  #rails runner Department::department　実行
  def self.department
    Department.create(:name => '営業部',:description => 'テスト1')
    Department.create(:name => 'オペレーション部',:description => 'テスト2')
    Department.create(:name => '事業開発部',:description => 'テスト3')
    Department.create(:name => 'Web開発事業部',:description => 'テスト4')
    Department.create(:name => '総務・会計部',:description => 'テスト5')
  end

end
