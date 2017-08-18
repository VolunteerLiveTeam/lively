class Team
  include Mongoid::Document
  include Scram::DSL::ModelConditions

  field :name, type: String
  groupify :group, members: :users

  has_many :events

  scram_define do
    condition :members do |team|
      User.in_group(team).map(&:scram_compare_value).to_a
    end
    condition :managers do |team|
      User.in_group(team).as(:manager).map(&:scram_compare_value).to_a
    end
  end

  def icon_url
    # TODO: allow image upload
    "https://s3-eu-west-1.amazonaws.com/ollycorp/vlt.png"
  end
end
