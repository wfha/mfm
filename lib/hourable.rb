module Hourable

  # Should Not Use Cache, Because you have to check the time every time your refresh the page!
  def still_open?
    time_now = Time.now
    flag = false
    hours.each do |hour|
      oa = Time.parse(hour.open_at).time_of_day!
      ca = Time.parse(hour.close_at).time_of_day!
      flag = true if hour.name.include?(time_now.wday.to_s) && (oa..ca).cover?(time_now.time_of_day!)
    end
    flag
  end
end