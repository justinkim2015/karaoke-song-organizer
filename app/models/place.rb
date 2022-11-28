class Place < ApplicationRecord
  belongs_to :user

  def open?(info)
    if info[:result][:current_opening_hours][:open_now] == true
      'OPEN'
    else
      'CLOSED'
    end
  end
  
  def hours(info)
    info[:result][:current_opening_hours][:weekday_text]
  end
end
