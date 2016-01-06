
# Unicornは複数のワーカーで起動するのでワーカーの数を定義する
# サーバーのメモリなどに寄って変更すること
worker_processes 2

# 基本的には'true'を指定する。Unicornの再起動時にダウンタイムなしで再起動が行われる
preload_app true


# ソケット！　一番重要！
# Nginxのconfig内にあるupstreamで、このパスを指定
listen "/tmp/unicorn.sock"
#listen "/tmp/unicorn.beedit.sock", :backlog => 64

# pidを保存するファイル
pid "/tmp/unicorn.pid"
#pid "/var/www/app/beedit/tmp/pids/unicorn.beedit.pid"

# Unicornのエラーログと通常ログの位置を指定。
# ファイルの書き込み権限を変更しておくこと
stderr_path "/var/www/beedit/log/unicorn.stderr.log"
stdout_path "/var/www/beedit/log/unicorn.stdout.log"
#stderr_path "/var/www/app/beedit/log/unicorn.stderr.log"
#stdout_path "/var/www/app/beedit/log/unicorn.stdout.log"

# capistrano 用に RAILS_ROOT を指定
# Unicornの起動コマンドを実行するディレクトリを指定します
working_directory "/var/www/beedit"
#working_directory "/var/www/app/beedit"

# 接続タイムアウト時間
timeout 30

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
