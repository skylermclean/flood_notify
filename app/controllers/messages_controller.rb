class MessagesController < ApplicationController 
 skip_before_filter :verify_authenticity_token
 #skip_before_filter :authenticate_user!, :only => "reply"

  def reply
    message_body = params["Body"]
    from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: 16266168993,
      body: "Hello there, you said, #{message_body}."
    )
    
  end

  def notification
    message_body = params["Body"]
    from_number = params["From"]
    message = params[:msg]
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: 16266168993,
      body: "Hello there, you have a missing order . #{message}."
    )

  end

  def notificationMissingOrder
    message_body = params["Body"]
    from_number = params["From"]
    to_number = params["To"]
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: 16266168993,
      body: "The test #{message_body} failed. Check DataFlood for details"
    )

  end


  private

  def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end
end
