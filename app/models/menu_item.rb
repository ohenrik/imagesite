class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :item_record, :polymorphic => true
end
