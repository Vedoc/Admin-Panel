ActiveAdmin.register Client do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :address
    column :phone
    column :created_at
    actions
  end

  filter :name
  filter :phone
  filter :address
  filter :created_at, filters: %i[starts_with ends_with]

  show do
    attributes_table do
      row( :avatar ) { | c | avatar_field( c.avatar ) }
      row :email
      row :name
      row :phone
      row :address
      row( :location ) { | c | pretty_location( c.location ) }
      row :created_at
      row :updated_at
    end
  end
end
