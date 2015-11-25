class Project < ActiveRecord::Base

  include DatetimeIntegratable

  REGISTRABLE_ATTRIBUTES = %i(
    sale_user_id
    company_id
    name

    arrival_date
    published_at_date published_at_hour published_at_minute
  )

  # DatetimeIntegratableで宣言した、 integrate_datetime_fields関数を利用
  # 下記のように宣言することで、モデル初期化時にpublished_atを
  # published_at_date, published_at_hour, published_at_minute に分解する
  #
  # モデル保存時に、date/hour/minute の3つの変数の値を
  # published_at に戻す
  integrate_datetime_fields :published_at
  
  validates :published_at_date, presence: true
  validates :published_at_hour, presence: true
  validates :published_at_minute, presence: true

end
