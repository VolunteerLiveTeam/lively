class Event
  include Mongoid::Document
  include Scram::DSL::ModelConditions

  belongs_to :team

  field :name, type: String
  validates :name, presence: true, length: { maximum: 120 }

  field :description, type: String
  validates :description, presence: true, length: { minimum: 16, maximum: 120 }

  # ID of the live thread on Reddit
  field :reddit_id, type: String
  validates :reddit_id, presence: true, length: { is: 12 }

  scram_define do
    condition :members do |event|
      event.team.send("*members")
    end
    condition :managers do |event|
      event.team.send("*managers")
    end
  end

  def reddit_url
    "https://reddit.com/live/#{reddit_id}"
  end

end
