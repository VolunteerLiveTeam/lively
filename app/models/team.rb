class Team
  include Mongoid::Document

  field :name, type: String
  groupify :group, members: :users
  
end
