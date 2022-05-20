ActiveAdmin.register CarModel do
  permit_params :car_make_id, :name

  filter :car_make
  filter :name
  filter :created_at
  filter :updated_at
end
