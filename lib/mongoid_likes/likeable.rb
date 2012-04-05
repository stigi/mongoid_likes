module Mongoid
  module Likeable
    extend ActiveSupport::Concern

    included do |base|
      base.field    :liked_count_field, :type => Integer, :default => 0
      base.has_many :likers_assoc, :class_name => 'Mongoid::Like', :as => :liked, :dependent => :destroy
    end

    # know if self is liked by model
    #
    # Example:
    # => @track.liker?(@joe)
    # => true
    def liker?(model)
      self.likers_assoc.find(:all, conditions: {like_id: model.id}).limit(1).count > 0
    end

    # get likers count
    # Note: this is a cache counter
    #
    # Example:
    # => @track.likers_count
    # => 1
    def likers_count
      self.liked_count_field
    end

    # get likers count by model
    #
    # Example:
    # => @track.likers_count_by_model(User)
    # => 1
    def likers_count_by_model(model)
      self.likers_assoc.where(:like_type => model.to_s).count
    end

    # view all selfs likers
    #
    # Example:
    # => @track.all_likers
    # => [@joe, @max]
    def all_likers
      get_likers_of(self)
    end

    # view all selfs likers by model
    #
    # Example:
    # => @track.all_likers_by_model
    # => [@joe]
    def all_likers_by_model(model)
      get_likers_of(self, model)
    end

    # view all common likers of self against model
    #
    # Example:
    # => @track.common_likers_with(@gang)
    # => [@joe, @max]
    def common_likers_with(model)
      model_likers = get_likers_of(model)
      self_likers = get_likers_of(self)

      self_likers & model_likers
    end

    private
    def get_likers_of(me, model = nil)
      likers = !model ? me.likers_assoc : me.likers_assoc.where(:like_type => model.to_s)

      likers.collect do |like|
        like.like_type.constantize.find(like.like_id)
      end
    end

    def method_missing(missing_method, *args, &block)
      if missing_method.to_s =~ /^(.+)_likers_count$/
        likers_count_by_model($1.camelize)
      elsif missing_method.to_s =~ /^all_(.+)_likers$/
        all_likers_by_model($1.camelize)
      else
        super
      end
    end
  end
end
