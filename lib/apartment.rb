class Apartment
  attr_reader :number,
              :monthly_rent,
              :bathrooms,
              :bedrooms,
              :renter

  def initialize(apt_param)
    @number       = apt_param[:number]
    @monthly_rent = apt_param[:monthly_rent]
    @bathrooms    = apt_param[:bathrooms]
    @bedrooms     = apt_param[:bedrooms]
    @renter       = nil
  end

  def add_renter(renter)
    @renter = renter
  end

end
