class User
  include Mongoid::Document
  include Scram::Holder
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
  
  # Sets up a relation where this user now stores "policy_ids". This is a one-way relationship!
  has_and_belongs_to_many :policies, class_name: "Scram::Policy"
  alias_method :user_policies, :policies # NOTE: This macro remaps the actual mongoid relation to be under the name user_policies, since we override it in User#policies to union in the DEFAULT_POLICIES

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def scram_compare_value
    self.id
  end

  # Overrides Scram::Holder#policies to union in this user's policies along with those default as default policies
  def policies 
    Scram::DEFAULT_POLICIES | self.user_policies
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
