class Event
  include Mongoid::Document
  include Scram::DSL::ModelConditions

  belongs_to :team
  field :name, type: String
  field :description, type: String

  # ID of the live thread on Reddit
  field :reddit_id, type: String

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
