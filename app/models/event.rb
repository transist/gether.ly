class Event
  include Mongoid::Document

  field :name, type: String
  field :start_time, type: Time
  field :end_time, type: Time
  field :location, type: String
  field :detail, type: String

  belongs_to :host, class_name: 'User'
  embeds_many :invitee, class_name: 'Identity'
  # How to connect them?
  embeds_many :invitations

  accepts_nested_attributes_for :invitations

  def as_json(options = nil)
    event = super
    event.delete('host_id')
    event
  end
end
