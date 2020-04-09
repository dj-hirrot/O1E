class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  enum role_level: { general: 0, viewer: 1, admin: 2, superadmin: 3 }

  has_many :subjects, dependent: :destroy
  has_many :tasks, dependent: :destroy

  before_save :downcase_attributes
  before_create :create_activation_token

  attr_accessor :remember_token, :activation_token, :reset_token

  validates :name, presence: true,
            length: { maximum: 15 },
            uniqueness: { case_sensitive: false }
  validates :email, presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true,
            length: { minimum: 6 },
            allow_nil: true

  has_secure_password

  ### 永続セッション有効化
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  ### ユーザーの有効化
  def activate
    update(activated: true, activated_at: Time.zone.now)
  end

  ### パラメータのトークンとダイジェストが一致するか
  def authenticated?(attr, token)
    digest = send("#{attr}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  ### ログイン情報の破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定用の属性をセットする
  def create_reset_digest
    self.reset_token = User.new_token
    update(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # パスワード再設定用のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定有効期間内かチェックする
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  ### 文字列をダイジェスト化する
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  ### ランダムなトークンを生成
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private
    def downcase_attributes
      self.name = name.downcase
      self.email = email.downcase
    end

    def create_activation_token
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
