class ShopMailer < ApplicationMailer
  def approved( shop )
    mail bcc: shop.accounts.pluck( :email ), subject: 'Vedoc Account Approved'
  end
end
