module VaccinesHelper
  def countries_of(vaccine)
    list = []
    vaccine.countries.ids.map do |country|  
    list << @countries.find(country).name
    end
    list.join(",")
  end
end
