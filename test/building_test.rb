require 'minitest/autorun'
require 'minitest/pride'
require './lib/renter'
require './lib/apartment'
require './lib/building'

class BuildingTest < Minitest::Test

  def test_it_exists
    building = Building.new

    assert_instance_of Building, building
  end

  def test_it_start_with_no_units
    building = Building.new

    assert_empty building.units
  end

  def test_it_can_add_units
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 2,
      bedrooms: 2
    })
    assert_empty building.units

    building.add_unit(unit1)
    building.add_unit(unit2)

    assert_equal [unit1, unit2], building.units
  end

  def test_it_can_add_renters
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 2,
      bedrooms: 2
    })
    building.add_unit(unit1)
    building.add_unit(unit2)
    renter1 = Renter.new("Aurora")
    renter2 = Renter.new("Tim")

    assert_empty building.renters
    unit1.add_renter(renter1)

    assert_equal ["Aurora"], building.renters

    unit2.add_renter(renter2)

    assert_equal ["Aurora", "Tim"], building.renters
  end

  def test_it_can_get_an_average_rent
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 2,
      bedrooms: 2
    })
    building.add_unit(unit1)
    building.add_unit(unit2)
    assert_equal 1099.5, building.average_rent
  end

  def test_total_rent
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 2,
      bedrooms: 2
    })
    building.add_unit(unit1)
    building.add_unit(unit2)

    assert_equal 2199, building.total_rent
  end

  def test_it_can_get_rented_units
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 1,
      bedrooms: 2
    })
    unit3 = Apartment.new({
      number: "C3",
      monthly_rent: 1150,
      bathrooms: 2,
      bedrooms: 2
    })
    unit4 = Apartment.new({
      number: "D4",
      monthly_rent: 1500,
      bathrooms: 2,
      bedrooms: 3
    })
    renter1 = Renter.new("Spencer")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)

    assert_empty building.rented_units

    unit2.add_renter(renter1)

    assert_equal [unit2], building.rented_units
  end

  def test_it_can_get_renter_with_hightest_rent
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 1,
      bedrooms: 2
    })
    unit3 = Apartment.new({
      number: "C3",
      monthly_rent: 1150,
      bathrooms: 2,
      bedrooms: 2
    })
    unit4 = Apartment.new({
      number: "D4",
      monthly_rent: 1500,
      bathrooms: 2,
      bedrooms: 3
    })
    renter1 = Renter.new("Spencer")
    renter2 = Renter.new("Jessie")
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    unit2.add_renter(renter1)
    unit1.add_renter(renter2)

    assert_equal renter2, building.renter_with_highest_rent
  end

  def test_it_can_serarate_by_number_of_bedrooms
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 1,
      bedrooms: 2
    })
    unit3 = Apartment.new({
      number: "C3",
      monthly_rent: 1150,
      bathrooms: 2,
      bedrooms: 2
    })
    unit4 = Apartment.new({
      number: "D4",
      monthly_rent: 1500,
      bathrooms: 2,
      bedrooms: 3
    })
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    building.add_unit(unit4)

    expected = {
      3 => ["D4"],
      2 => ["B2", "C3"],
      1 => ["A1"]
    }

    assert_equal ["D4"], building.units_by_number_of_bedrooms[3]
    assert_equal ["B2", "C3"], building.units_by_number_of_bedrooms[2]
    assert_equal ["A1"], building.units_by_number_of_bedrooms[1]
  end

  def test_annual_breakdown
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 1000,
      bathrooms: 1,
      bedrooms: 2
    })
    unit3 = Apartment.new({
      number: "C3",
      monthly_rent: 1150,
      bathrooms: 2,
      bedrooms: 2
    })
    unit4 = Apartment.new({
      number: "D4",
      monthly_rent: 1500,
      bathrooms: 2,
      bedrooms: 3
    })
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    building.add_unit(unit4)
    renter1 = Renter.new("Spencer")
    unit2.add_renter(renter1)

    assert_equal ({"Spencer" => 12000}), building.annual_breakdown

    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)

    assert_equal ({"Jessie" => 14400, "Spencer" => 12000}), building.annual_breakdown
  end

  def test_it_can_get_rooms_by_renter
    building = Building.new
    unit1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    unit2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 1,
      bedrooms: 2
    })
    unit3 = Apartment.new({
      number: "C3",
      monthly_rent: 1150,
      bathrooms: 2,
      bedrooms: 2
    })
    unit4 = Apartment.new({
      number: "D4",
      monthly_rent: 1500,
      bathrooms: 2,
      bedrooms: 3
      })
    building.add_unit(unit1)
    building.add_unit(unit2)
    building.add_unit(unit3)
    building.add_unit(unit4)
    renter1 = Renter.new("Spencer")
    unit2.add_renter(renter1)
    renter2 = Renter.new("Jessie")
    unit1.add_renter(renter2)

    expected = {
      renter2 => {bathrooms: 1, bedrooms: 1},
      renter1 => {bathrooms: 1, bedrooms: 2}
    }
    assert_equal expected, building.rooms_by_renter
  end

end
