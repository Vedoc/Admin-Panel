ActiveAdmin.register Shop do
  actions :index, :show, :destroy

  member_action :approve, method: :patch do
    ShopMailer.approved( resource ).deliver_later if resource.update( approved: true )

    redirect_to resource_path, notice: I18n.t( 'admin.shops.messages.approved' )
  end

  action_item :approve, only: :show, if: proc { !resource.approved? } do
    link_to(
      I18n.t( 'admin.shops.actions.approve' ),
      approve_admin_shop_path( resource ),
      method: :patch,
      data: { confirm: I18n.t( 'admin.shops.messages.confirm_approve' ) }
    )
  end

  index do
    selectable_column
    id_column
    column( :email ) { | s | s.accounts.where( employee: false ).first&.email }
    column :name
    column :owner_name
    column :phone
    column :address
    column :approved
    column :created_at
    actions
  end

  filter :name
  filter :owner_name
  filter :phone
  filter :address
  filter :approved
  filter :created_at, filters: %i[starts_with ends_with]

  show do
    attributes_table do
      row( :avatar ) { | s | avatar_field( s.avatar ) }
      row :name
      row( :email ) { | s | s.accounts.where( employee: false ).first&.email }
      row :owner_name
      row :approved
      row :phone
      row :address
      row( :location ) { | s | pretty_location( s.location ) }
      row :hours_of_operation
      row :techs_per_shift
      row :certified
      row :lounge_area
      row :supervisor_permanently
      row( :languages ) { | shop | shop.languages.join( ', ' ) }
      row :tow_track
      row :complimentary_inspection
      row :vehicle_diesel
      row :vehicle_electric
      row :vehicle_warranties
      row( :categories ) do | shop |
        shop.categories.map { | category | Shop::CATEGORIES.keys[ category ].to_s.titleize }.join ', '
      end
      row( :pictures ) do | s |
        pictures_list( self, s.pictures )
      end
      row :created_at
      row :updated_at
    end
  end
end
