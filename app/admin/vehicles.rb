ActiveAdmin.register Vehicle do
  actions :index, :show, :destroy

  index do
    selectable_column
    id_column
    column :client
    column :make
    column :model
    column :year
    column :category
    column :created_at
    actions
  end

  filter :client
  filter :make
  filter :model
  filter :year
  filter :category
  filter :created_at, filters: %i[starts_with ends_with]

  show do
    attributes_table do
      row( :photo ) { | v | avatar_field( v.photo ) }
      row :client
      row :make
      row :model
      row :year
      row :category
      row :created_at
      row :updated_at
    end
  end
end
