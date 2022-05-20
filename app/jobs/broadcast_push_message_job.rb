class BroadcastPushMessageJob < ApplicationJob
  queue_as :default

  def perform( message )
    FirebaseMessaging::UserNotificationSender.new(
      user_device_ids: Device.pluck( :device_token ),
      message: message,
      payload: { type: 'global_message' }
    ).call
  end
end
