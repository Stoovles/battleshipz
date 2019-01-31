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

  def render(optional = false)
    if fired_upon? && !empty? && ship.sunk?
      "X"
    elsif fired_upon? && !empty? && !ship.sunk?
      "H"
    elsif fired_upon? && empty?
      "M"
    elsif optional == true && @ship != nil
      "S"
    else
      "."
    end
  end

end
