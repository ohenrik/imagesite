class MenuItem < ActiveRecord::Base
  belongs_to :menu
  belongs_to :menuable, :polymorphic => true
  has_ancestry
end
