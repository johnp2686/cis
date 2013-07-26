module ApplicationHelper
  def claim_ID
    Customer.find(@iw).try(:claims).map(&:id).first
  end

  def customer_claim_ID
    Customer.find(current_user.id).try(:claims).map(&:id).first
  end 

  def duration_of_time(time)
    difference = Time.now.to_i - time.to_i
    seconds    =  difference % 60
    difference = (difference - seconds) / 60
    minutes    =  difference % 60
    difference = (difference - minutes) / 60
    hours      =  difference % 24
    difference = (difference - hours)   / 24
    days       =  difference % 7
    weeks      = (difference - days)    /  7
    local_time = time.getlocal.strftime("%I:%M %p")
    return "#{local_time}"+"(#{weeks} weeks ago )" if weeks != 0
    return "#{local_time}"+"(#{days} days ago) " if days != 0
    return "#{local_time}"+"(#{hours} hours ago)" if difference !=0
    return "#{local_time}"+"(#{minutes} minutes ago)" if minutes !=0
  end

  def time_and_day(time)
    t = time.getlocal
   return "#{t.strftime("%d/%m/%Y")}"+"#{t.strftime(" %I:%M%p")}"
  end

  def current_role
    current_user.roles.first.role
  end

end
