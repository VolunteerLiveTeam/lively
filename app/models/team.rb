class Team
  include Mongoid::Document

  field :name, type: String
  groupify :group, members: :users
  
  def icon_url
    # TODO: allow image upload
    "https://s3-eu-west-1.amazonaws.com/ollycorp/vlt.png"
  end
end
