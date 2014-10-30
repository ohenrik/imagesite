class AddConfirmedAtTimeToUsers < ActiveRecord::Migration
  def self.up
    if ActiveRecord::Base.connection.current_schema == 'public'
        User.all.each do |user|
          if user.confirmed_email_at.blank?
            user.confirmed_email_at = Time.now
            user.save
          end
        end
    end
  end
end
