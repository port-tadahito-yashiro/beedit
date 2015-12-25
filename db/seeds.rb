# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def self.department
  Department.connection.execute('TRUNCATE TABLE departments;')
  Department.create(:id => 1,:name => '営業部',:description => 'テスト1',:created_at => Time.now, :created_time => Time.now.to_i, :created_user => 1, :updated_at => Time.now, :updated_time => Time.now.to_i, :updated_user => 1)
  Department.create(:id => 2,:name => 'オペレーション部',:description => 'テスト2',:created_at => Time.now, :created_time => Time.now.to_i, :created_user => 1, :updated_at => Time.now, :updated_time => Time.now.to_i, :updated_user => 1)
  Department.create(:id => 3,:name => '事業開発部',:description => 'テスト3',:created_at => Time.now, :created_time => Time.now.to_i, :created_user => 1, :updated_at => Time.now, :updated_time => Time.now.to_i, :updated_user => 1)
  Department.create(:id => 4,:name => 'Web開発事業部',:description => 'テスト4',:created_at => Time.now, :created_time => Time.now.to_i, :created_user => 1, :updated_at => Time.now, :updated_time => Time.now.to_i, :updated_user => 1)
  Department.create(:id => 5,:name => '総務・会計部',:description => 'テスト5',:created_at => Time.now, :created_time => Time.now.to_i, :created_user => 1, :updated_at => Time.now, :updated_time => Time.now.to_i, :updated_user => 1)
end

Admin.create(:id => 1,:department_id => 1,:name => 'root',:email => 'root',:password => '6a08867492fbfbeaaf697466b79ee5b03715d016',:salt => '0.7717607766381626',:created_at => Time.now, :created_time => Time.now.to_i, :created_user => 1, :updated_at => Time.now, :updated_time => Time.now.to_i, :updated_user => 1)
