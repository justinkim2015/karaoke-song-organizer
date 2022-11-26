class Place < ApplicationRecord
  belongs_to :user

  def open?(info)
    if info[:result][:current_opening_hours][:open_now] == true
      'Open now!'
    else
      'Closed'
    end
  end

  def hours(info)
    info[:result][:current_opening_hours][:weekday_text]
  end
end
