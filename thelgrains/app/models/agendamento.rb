# == Schema Information
#
# Table name: agendamentos
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  cliente_id  :integer
#  title       :string
#  description :text
#  start_time  :datetime
#  end_time    :datetime
#  all_day     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'time'

##
# Model da tabela _agendamentos_.
class Agendamento < ActiveRecord::Base
  belongs_to :user
  belongs_to :cliente

  validates_presence_of :user, :start_time, :end_time
  # validate :start_not_before_now

  scope :between, ->(start_time, end_time) {
    where("start_time > ? and end_time < ?", start_time, end_time)
  }

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
  def as_json(options = {})
    {
      :id => self.id,
      :title => self.cliente.try(:nome) || self.title,
      :description => self.description || "",
      :start => start_time.rfc822,
      :end => end_time.rfc822,
      :allDay => self.all_day,
      :recurring => false,
      :url => Rails.application.routes.url_helpers.agendamento_path(id),
    }
  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  private

  ##
  # Valida se o +start_time+ não é anterior a hoje.
  def start_not_before_now
    return true if start_time >= DateTime.now
    errors.add(:start, 'a data/hora deve ser depois da data/hora atual')
  end
end
