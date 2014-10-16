RobotNamingError = Class.new(RuntimeError)
NameCollisionError = Class.new(RobotNamingError)
InvalidNameError = Class.new(RobotNamingError)

class Robot
  attr_accessor :name

  @@registry = []

  def initialize(args = {})
    @name = generate_name(args[:name_generator] || @@default_name_generator)
    @@registry << @name
  end

  @@default_name_generator = lambda do
    chars = ('A'..'Z').to_a
    2.times.map { chars.sample }.concat(3.times.map { (rand 10).to_s }).join('')
  end

  private

  # Recovers dynamic generators; won't scale to >> #'s of robots...
  def generate_name(name_generator)
    100.times do |i|
      name = generate_valid_name(name_generator)
      return name unless @@registry.include?(name)
      name_generator = @@default_name_generator if i == 85  # last resort
    end

    raise NameCollisionError, 'There was a problem generating the robot name!'
  end

  def generate_valid_name(name_generator)
    name = name_generator.call
    raise InvalidNameError, 
          "Invalid robot name #{name}" unless name =~ /[[:alpha:]]{2}\d{3}/
    name
  end
end

# robot = Robot.new
# puts "My pet robot's name is #{robot.name}, but we usually call him sparky."

# Errors!
# generator = -> { 'AA111' }
# Robot.new(name_generator: generator)
# Robot.new(name_generator: generator)
