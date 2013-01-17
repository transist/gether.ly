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

  def time_range
    return @time_range if @time_range

    if start_time.beginning_of_day.to_i == end_time.beginning_of_day.to_i
      # RubyMotion does implement %P for Time#strftime so we need downcase it manually
      @time_range = start_time.strftime('%a, %b %-d ')
      @time_range << 'from '
      @time_range << start_time.strftime('%-l:%M%p ').downcase
      @time_range << 'to '
      @time_range << end_time.strftime('%-l:%M%p').downcase
    else
      @time_range = 'From '
      @time_range << start_time.strftime('%a, %b %-d ')
      @time_range << start_time.strftime('%-l:%M%p ').downcase
      @time_range = 'to '
      @time_range << end_time.strftime('%a, %b %-d ')
      @time_range << end_time.strftime('%-l:%M%p').downcase
    end
  end
end
