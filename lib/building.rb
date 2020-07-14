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
  #
  # end

  # def renter_with_highest_rent
  #
  # end

  # def units_by_number_of_bedrooms
  #
  # end
end
