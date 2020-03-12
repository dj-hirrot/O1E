class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :downcase_attributes
  before_create :create_activation_token

  attr_accessor :remember_token, :activation_token

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

  ### パラメータのトークンとダイジェストが一致するか
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    Bcrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  ### ログイン情報の破棄
  def forget
    update_attribute(:remember_digest, nil)
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
