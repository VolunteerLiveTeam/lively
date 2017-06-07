class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable,
         :omniauthable, :omniauth_providers => [:reddit]

  field :name, type: String

  ## Database authenticatable
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Rememberable
  field :remember_created_at, type: Time

  # Omniauthable
  field :provider, type: String
  field :uid, type: String

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
