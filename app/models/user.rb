class User
  include Mongoid::Document
  # Include devise modules
  devise :database_authenticatable, :rememberable,
         :omniauthable, :omniauth_providers => [:reddit]

  # Devise fields
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :remember_created_at, type: Time
  field :provider, type: String
  field :uid, type: String

  field :name, type: String
  groupify :group_member
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def display_name
    "/u/#{name}"
  end

  def current_team
    team_id = Redis.current.get("user:#{id}:current_team")
    team_id.nil? ? nil : Team.find(team_id)
  end

  def current_team=(team)
    Redis.current.set("user:#{id}:current_team", team.id)
  end
end
