class Game < ActiveRecord::Base
	belongs_to :park
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :players, :class_name => "User", through: :reservations

  # boolean check - does this game have any reservations?
  def has_reservations?
    self.reservations.length > 0
  end

  # boolean check - does this game have any open spots?
  def has_open_spots?
    open_spots > 0
  end

  # returns number of open spots
  def open_spots
    if has_reservations?
      self.player_limit - self.reservations.length  
    else
      self.player_limit
    end
  end

end