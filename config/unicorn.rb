application = 'beedit'


# Unicornは複数のワーカーで起動するのでワーカーの数を定義する
# サーバーのメモリなどに寄って変更すること
worker_processes 2

app_path = "/var/www/beedit"
# 基本的には'true'を指定する。Unicornの再起動時にダウンタイムなしで再起動が行われる
preload_app true


# ソケット！　一番重要！
listen "#{app_path}/shared/tmp/sockets/unicorn.sock"
pid "#{app_path}/current/tmp/unicorn.pid"



# capistrano 用に RAILS_ROOT を指定
# Unicornの起動コマンドを実行するディレクトリを指定します
working_directory "/var/www/#{application}"

# 接続タイムアウト時間
timeout 30

# 環境の判別
if ENV['RAILS_ENV'] == 'production'
  shared_path = "/var/www/#{application}/shared"

  # Unicornのエラーログと通常ログの位置を指定。
  stderr_path = "#{app_path}/current/log/unicorn.stderr.log"
  stdout_path = "#{app_path}/current/log/unicorn.stdout.log"
end

# Unicornのエラーログと通常ログの位置を指定。
stderr_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])


# USR2シグナルを受けると古いプロセスを止める
#
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  # プロセスidの判別　違ったらkill
  unless old_pid == server.pid
    begin
      # SIGTTOU だと worker_processes が多いときおかしい気がする
      Process.kill :QUIT, File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
