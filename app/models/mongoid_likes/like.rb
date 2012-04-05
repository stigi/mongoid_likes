module Mongoid
  class Like
    include Mongoid::Document

    field :like_type
    field :like_id

    belongs_to :liker, :polymorphic => true
    belongs_to :liked, :polymorphic => true
  end
end