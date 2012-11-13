class Invitation
  include Mongoid::Document

  embedded_in :event
  embeds_one :invitee, class_name: 'Identity'
end
