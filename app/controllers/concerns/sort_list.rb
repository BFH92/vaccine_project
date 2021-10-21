def sort_list(list, sorted_list)
  list.select{|x| x["mandatory"] == "yes" && x["last_injection_date"] == nil}.map do |hash|
    sorted_list << hash
  end
  list.select{|x| x["mandatory"] == "no" && x["last_injection_date"] == nil}.map do |hash|
    sorted_list << hash
  end
  list.select{|x| x["last_injection_date"] != nil}.map do |hash|
    sorted_list << hash
  end
end