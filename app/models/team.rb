class Team
  include Mongoid::Document
  include Mongoid::Paperclip
  include Scram::DSL::ModelConditions

  field :name, type: String
  groupify :group, members: :users

  has_mongoid_attached_file :logo, styles: {
    :original => ['512x512>', :png],
    :icon => ['32x32#', :png]
  }
  validates_attachment :logo, content_type: { content_type: ["image/png"] }

  has_many :events

  scram_define do
    condition :members do |team|
      User.in_group(team).map(&:scram_compare_value).to_a
    end
    condition :managers do |team|
      User.in_group(team).as(:manager).map(&:scram_compare_value).to_a
    end
  end

end
