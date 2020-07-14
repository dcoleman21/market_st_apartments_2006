class Building
  attr_reader :units,
              :renters

  def initialize
    @units   = []
    @renters = []
  end

  def add_unit(unit)
    @units << unit
  end

  def add_renter(renter)
    @renters << renter
  end

  def average_rent
    average = @units.sum do |unit|
      (unit.monthly_rent.to_f / 2).round(2)
    end
  end

end
