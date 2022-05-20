ActiveAdmin.register Account do
  actions :index, :show, :destroy

  menu label: 'Employees'

  controller do
    def scoped_collection
      Account.where employee: true, accountable_type: 'Shop'
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column( :shop ) do | a |
      link_to a.accountable.name, admin_shop_path( a.accountable_id )
    end
    column :created_at
    actions
  end

  filter :email
  filter :accountable_of_Shop_type_name, label: 'Shop Name', as: :string
  filter :created_at, filters: %i[starts_with ends_with]

  show do
    attributes_table do
      row :email
      row( :shop ) do | a |
        link_to a.accountable.name, admin_shop_path( a.accountable_id )
      end
      row :created_at
      row :updated_at
    end
  end
end
