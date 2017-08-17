class Team
  include Mongoid::Document
  include Scram::DSL::ModelConditions

  field :name, type: String
  groupify :group, members: :users

  scram_define do
    condition :managers do |team|
      User.in_group(team).as(:admin).map(&:scram_compare_value).to_a
    end
  end

  def icon_url
    # TODO: allow image upload
    "https://s3-eu-west-1.amazonaws.com/ollycorp/vlt.png"
  end
end
