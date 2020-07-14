class Building
  attr_reader :units,
              :renters,
              # :rented_units

  def initialize
    @units        = []
    @renters      = []
    # @rented_units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def add_renter(renter)
    @renters = @renter
  end

  def average_rent
    average = @units.sum do |unit|
      (unit.monthly_rent.to_f / 2).round(2)
    end
  end

  # def rented_units
  #I would use a find enum here
  # end

  # def renter_with_highest_rent
  #I would use the max_by enum here
  # end

  # def units_by_number_of_bedrooms
  #I would use the sort_by or group_by enum here
  # end
end
