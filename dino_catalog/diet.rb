# DinoDiet
#
# Objects that represent the various specific types of diets that dinosaurs can have.
class DinoDiet
  
  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous    # Whether the diet is considered carnivorous (boolean)

  def initialize(diet_name, is_carnivore)
    @diet, @carnivorous = diet_name, is_carnivore
  end

  INSECTIVORE               = new("insectivore", true),
  PISCIVORE                 = new("piscivore", true),
  CARNIVORE                 = new("carnivorous", true),
  UNSPECIFIED_CARNIVORE     = new("unspecified carnivore", true),
  UNSPECIFIED_NONCARNIVORE  = new("unspecified non-carnivore", false),
  UNKNOWN_DIET              = new("unknown diet", false)
end
