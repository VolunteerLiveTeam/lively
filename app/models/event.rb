class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Mongoid::Paperclip
  include Scram::DSL::ModelConditions

  belongs_to :team
  belongs_to :creator, class_name: 'User'

  field :name, type: String
  validates :name, presence: true, length: { maximum: 120 }

  field :description, type: String
  validates :description, presence: true, length: { minimum: 16, maximum: 120 }

  field :url, type: String
  validates :url, presence: true, length: { minimum: 4, maximum: 24 }
  slug :url

  # ID of the live thread on Reddit
  field :reddit_id, type: String
  validates :reddit_id, presence: true, length: { is: 12 }

  has_mongoid_attached_file :image, styles: {
    :original => ['1920x1680>', :jpg],
    :social => ['952x498#', :png]
  }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

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
