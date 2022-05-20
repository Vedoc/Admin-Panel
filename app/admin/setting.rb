ActiveAdmin.register_page 'Setting' do
  title = 'Settings'
  menu label: title, priority: 99
  active_admin_settings_page(
    title: title,
    starting_with: 'service_request_fee',
    after_save: -> { Setting.service_request_fee = 0 if Setting.service_request_fee.negative? }
  )
end
