module ActiveAdmin
  module ViewsHelper
    def pretty_location( location )
      return nil if location.blank?

      "Longitude: #{ location.lon }; Latitude: #{ location.lat }"
    end

    def vehicle_name( vehicle )
      "#{ vehicle.make } #{ vehicle.model } #{ vehicle.year }"
    end

    def avatar_field( avatar )
      image_tag( avatar.url, class: 'picture' ) if avatar.url
    end

    def pictures_list( context, pictures )
      context.ul class: 'pictures-list' do
        pictures.each do | picture |
          context.li do
            context.image_tag( picture.data.url )
          end
        end
      end
    end
  end
end
