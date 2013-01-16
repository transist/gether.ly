class Invitation
  include Mongoid::Document

  field :email, type: String
  field :name, type: String
  field :token, type: String

  after_create :generate_token

  belongs_to :event

  state_machine :initial => :created do
    event :send_invitation do
      transition :created => :sent
    end

    event :accept do
      transition :sent => :accepted
    end

    event :decline do
      transition :sent => :declined
    end
  end

  def mail
    subject = "#{name} you are invited to #{event.name}"
    template_name = 'invitation'
    email_address = Rails.env == 'production' ? self.email : 'simsicon@gmail.com'
    self.send_invitation if Email.send_mail(subject, template_name, email_address, email_params)
  end

  def email_params
    {
      invitee: self.name,
      event_name: event.name,
      host: self.event.host.name,
      location: self.event.location,
      time_range: self.event.time_range,
      detail: self.event.detail,
      accept_url: accept_url,
      decline_url: decline_url
    }
  end

  def accept_url
    if Rails.env == 'production'
      url = "http://staging.getherly.com/v1/events/#{self.event._id}/accept?token=#{self.token}"
    else
      url = "http://127.0.0.1:3000/v1/events/#{self.event._id}/accept?token=#{self.token}"
    end
  end

  def decline_url
    if Rails.env == 'production'
      url = "http://staging.getherly.com/v1/events/#{self.event._id}/decline?token=#{self.token}"
    else
      url = "http://127.0.0.1:3000/v1/events/#{self.event._id}/decline?token=#{self.token}"
    end
  end

  protected
  def generate_token
    self.update_attributes token: SecureRandom.hex(8)
  end
end
