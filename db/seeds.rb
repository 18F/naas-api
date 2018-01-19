%w[GSA DHS VA].each do |agency|
  Notification.find_or_create_by(name: agency) do |a|
    a.created_by = 'Auto-generated'
  end
end
%w[jonathan.carmack@gsa.gov].each do |user|
  User.find_or_create_by(email: user) do |u|
    u.password = 'password12'
    u.password_confirmation = 'password12'
    u.last_name = 'Carmack'
    u.phone = '18082246036'
  end
end