ActiveAdmin.register ServiceRequest do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column( :client ) { | s | s.vehicle.client }
    column( :vehicle ) do | s |
      link_to vehicle_name( s.vehicle ), admin_vehicle_path( s.vehicle.id )
    end
    column :title
    column :estimated_budget
    column :address
    column( :status ) { | s | s.status.titleize }
    column( :category ) { | s | s.category.titleize }
    column :created_at
    actions
  end

  filter :vehicle, as: :select, collection: lambda {
    Vehicle.all.map do | v |
      [ "#{ vehicle_name( v ) } (#{ v.client.name })", v.id ]
    end
  }
  filter :title
  filter :estimated_budget
  filter :address
  filter :status
  filter :category
  filter :created_at, filters: %i[starts_with ends_with]

  show do | service_request |
    attributes_table do
      row( :client ) { | s | s.vehicle.client }
      row :title
      row :summary
      row :estimated_budget
      row( :paid ) { service_request.offers.accepted_only.first&.paid }
      row( :category ) { | s | s.category.titleize }
      row( :vehicle ) do | s |
        link_to vehicle_name( s.vehicle ), admin_vehicle_path( s.vehicle.id )
      end
      row :location
      row :address
      row :evacuation
      row :repairs_parts
      row :schedule_service
      row :vin
      row( :status ) { | s | s.status.titleize }
      row :created_at
      row :updated_at
      row( :pictures ) do | s |
        pictures_list( self, s.pictures )
      end
    end
  end
end
