%w[GSA DHS VA].each do |agency|
  Agency.find_or_create_by(name: agency) do |a|
    a.created_by = 'Auto-generated'
  end
end