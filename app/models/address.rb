class Address < ActiveRecord::Base

  attr_accessible :address1, :address2, :city, :state, :country, :zip,
                  :gmaps, :latitude, :longitude

  belongs_to :addressable, :polymorphic => true

  # ========== geocoder ==========

  geocoded_by :address

  after_validation :geocode

  def address
    [address1, address2, city, state, country, zip].compact.join(', ')
  end

  # ========== gmaps4rails ==========

  acts_as_gmappable :process_geocoding => false

  def gmaps4rails_address
    "#{self.address1}, #{self.address2}, #{self.city}, #{self.state}, #{self.country}"
  end

  def gmaps4rails_infowindow
    "<b>#{self.address1}</b><br/>#{self.addressable.name}"
  end

  def gmaps4rails_title
    "Hello I am Title!"
  end

  def gmaps4rails_marker_picture
    {
        "picture" => "#{self.addressable.image_url(:small).to_s}",
        "width" => 50,
        "height" => 64,
        "marker_anchor" => [ 5, 10],
        "shadow_picture" => "/assets/yelp_logo.png" ,
        "shadow_width" => "110",
        "shadow_height" => "110",
        "shadow_anchor" => [5, 10],
    }
  end

  def gmaps4rails_sidebar
    "<span class='foo'>#{self.addressable.name}</span>"
  end

end
