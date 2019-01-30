class Cell

attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_object)
    @ship = ship_object
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end 
  end

  def fired_upon?
    @fired_upon
  end

  def render
  #need to ask about boolean parameters
  #to render "S" - for now created a new method
    if @fired_upon == true && @ship != nil && ship.health == 0
      puts "X"
    elsif @fired_upon == true && @ship != nil && ship.health != 0
      puts "H"
    elsif @fired_upon == true && @ship == nil
      puts "M"
    else
      puts "."
    end
  end

  def render(true)
    if @fired_upon == true && @ship != nil && ship.health == 0
      puts "X"
    elsif @ship != nil && @fired_upon == false
      puts "S"
    elsif @ship != nil && @fired_upon == true
      puts "H"
    elsif @ship == nil && @fired_upon == true
      puts "M"
    else
      puts "."
    end
  end
end
