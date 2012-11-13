class Identity
  include Mongoid::Document

  field :email, type: String
  field :name, type: String

  embedded_in :invitation
end
