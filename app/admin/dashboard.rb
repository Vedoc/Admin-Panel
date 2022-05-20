ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t 'active_admin.dashboard' }

  content title: proc { I18n.t 'active_admin.dashboard' } do
    columns do
      column do
        panel 'Recent Clients' do
          table_for Client.order( id: :desc ).limit( 10 ) do
            column( :id ) { | client | link_to client.id, admin_client_path( client ) }
            column :email
            column :name
            column :phone
            column :address
            column :created_at
          end
        end
      end

      column do
        panel 'Recent Shops' do
          table_for Shop.order( id: :desc ).limit( 10 ) do
            column( :id ) { | shop | link_to shop.id, admin_shop_path( shop ) }
            column :name
            column :phone
            column :address
            column :created_at
          end
        end
      end
    end
  end
end
