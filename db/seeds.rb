AdminUser.find_or_create_by( email: ENV[ 'ADMIN_EMAIL' ] ) do | admin |
  admin.password = ENV[ 'ADMIN_PASSWORD' ]
end
