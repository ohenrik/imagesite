class StaticPagesController < ApplicationController

  def home
    
  end

  def pre_launch_news
    subscribe_to_mailchimp(params[:email], params[:name])
    redirect_to root_url, notice: "Thank you #{params[:name]}. #{params[:email]} is now added to our email list."
  end


private
  def subscribe_to_mailchimp(email, name)
    list_id = ENV['MAILCHIMP_ULUDUM_LIST_ID']

    gb = Gibbon::API.new

    response = gb.lists.subscribe({
      id: list_id,
      email: {email: email},
      double_optin: false,
      :merge_vars => {'FNAME' => name},
      :send_welcome => true
    })
    response
  end


end