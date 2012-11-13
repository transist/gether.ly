class Event
  include Mongoid::Document

  field :name, type: String
  field :start_time, type: Time
  field :end_time, type: Time
  field :location, type: String
  field :detail, type: String

  belongs_to :host, class_name: 'User'
  embeds_many :invitations

  accepts_nested_attributes_for :invitations
end
