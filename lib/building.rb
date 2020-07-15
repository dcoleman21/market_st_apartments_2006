class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def add_unit(unit)
    @units << unit
  end

  def renters
    @units.map do |unit|
      unit.renter.name if unit.renter
    end.compact
  end

  def average_rent
    total_rent.to_f / @units.count
  end

  def total_rent
    @units.sum do |unit|
      unit.monthly_rent
    end
  end

  def rented_units
    @units.find_all do |unit|
      unit.renter
    end
  end

  def renter_with_highest_rent
    most_expensive_unit.renter
  end

  def most_expensive_unit
    rented_units.max_by do |unit|
      unit.monthly_rent
    end
  end

  def units_by_number_of_bedrooms
    hash = {}
    @units.each do |unit|
      if hash[unit.bedrooms].nil?
        hash[unit.bedrooms] = [unit.number]
      else
        hash[unit.bedrooms] << unit.number
      end
    end
    hash
  end

  def annual_breakdown
    hash = {}
    rented_units.each do |unit|
      hash[unit.renter.name] = unit.monthly_rent * 12
    end
    hash
  end

  def rooms_by_renter
    hash = {}
    rented_units.each do |unit|
      hash[unit.renter] = {bathrooms: unit.bathrooms, bedrooms: unit.bedrooms}
    end
    hash
  end
end


# rented_units.reduce({}) do |hash, unit|
#   hash[unit.renter] = {bathrooms: unit.bathrooms, bedrooms: unit.bedrooms}
#   hash
