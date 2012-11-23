class Event
  include Mongoid::Document

  field :name, type: String
  field :start_time, type: Time
  field :end_time, type: Time
  field :location, type: String
  field :detail, type: String

  belongs_to :host, class_name: 'User', inverse_of: :created_hosts

  has_many :invitations

  def as_json(options = nil)
    event = super
    event.delete('host_id')
    event
  end
end
