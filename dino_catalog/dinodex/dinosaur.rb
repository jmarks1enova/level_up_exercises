class Dinodex::Dinosaur

  attr_accessor :taxon        # Name of dinosaur
  attr_accessor :time_period  # When dinosaur lived
  attr_accessor :weight       # Weight of animals in lbs
  attr_accessor :diet         # What dinosaur ate
  attr_accessor :ambulation   # Mode of locomotion
  attr_accessor :continent    # Geographic region of residence
  attr_accessor :description  # Human-readable informational message

  def initialize(taxon, period, weight, ambulation, other = {})

    @taxon, @period, @weight, @ambulation = taxon, period, weight, ambulation
    @diet = other[:diet]
    @description = other[:description]
    @continent = other[:continent]
  end

  def carnivorous?
    diet.carnivorous?
  end

  def to_s
    "DINOSAUR #{taxon} PRINTING ITSELF HERE"
  end
end
