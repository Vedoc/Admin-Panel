ActiveAdmin.register_page 'Push Notifications' do
  MESSAGE_MAXLENGTH = 1000

  page_action :send_push, method: :post do
    message = params[ :message ]

    return redirect_to admin_push_notifications_path, alert: "Message can't be blank" if message.blank?
    return redirect_to admin_push_notifications_path, alert: 'Message is too long' if message.length > MESSAGE_MAXLENGTH

    BroadcastPushMessageJob.perform_later message

    redirect_to admin_push_notifications_path, notice: 'Success'
  end

  content do
    form action: 'push_notifications/send_push', method: :post do | f |
      panel "Message (#{ MESSAGE_MAXLENGTH } characters max)" do
        f.textarea name: :message, type: :text, maxlength: MESSAGE_MAXLENGTH, id: 'push_message', rows: 5
      end
      f.input name: :authenticity_token, type: :hidden, value: form_authenticity_token.to_s
      f.input :submit, type: :submit
    end
  end
end
