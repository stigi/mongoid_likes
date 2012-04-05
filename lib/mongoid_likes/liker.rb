module Mongoid
  module Liker
    extend ActiveSupport::Concern

    included do |base|
      base.field    :likes_count_field, :type => Integer, :default => 0
      base.has_many :likes_assoc, :class_name => 'Mongoid::Like', :as => :liker, :dependent => :destroy
    end

    # like a model
    #
    # Example:
    # => @joe.like(@track)
    def like(model)
      if self.id != model.id && !self.likes?(model)

        model.before_liked_by(self) if model.respond_to?('before_liked_by')
        model.likers_assoc.create!(:like_type => self.class.name, :like_id => self.id)
        model.inc(:liked_count_field, 1)
        model.after_liked_by(self) if model.respond_to?('after_liked_by')

        self.before_like(model) if self.respond_to?('before_like')
        self.likes_assoc.create!(:like_type => model.class.name, :like_id => model.id)
        self.inc(:likes_count_field, 1)
        self.after_like(model) if self.respond_to?('after_like')

        return true
      else
        return false
      end
    end

    # unlike a model
    #
    # Example:
    # => @joe.unlike(@track)
    def unlike(model)
      if self.id != model.id && self.likes?(model)

        # this is necessary to handle mongodb caching on collection if unlike is following a like
        model.reload
        self.reload

        model.before_unliked_by(self) if model.respond_to?('before_unliked_by')
        model.likers_assoc.where(:like_type => self.class.name, :like_id => self.id).destroy
        model.inc(:liked_count_field, -1)
        model.after_unliked_by(self) if model.respond_to?('after_unliked_by')

        self.before_unlike(model) if self.respond_to?('before_unlike')
        self.likes_assoc.where(:like_type => model.class.name, :like_id => model.id).destroy
        self.inc(:likes_count_field, -1)
        self.after_unlike(model) if self.respond_to?('after_unlike')

        return true
      else
        return false
      end
    end

    # know if self is already liking model
    #
    # Example:
    # => @joe.likes?(@tracks)
    # => true
    def likes?(model)
      self.likes_assoc.find(:all, conditions: {like_id: model.id}).limit(1).count > 0
    end

    # get likes count
    # Note: this is a cache counter
    #
    # Example:
    # => @joe.likes_count
    # => 1
    def likes_count
      self.likes_count_field
    end

    # get likes count by model
    #
    # Example:
    # => @joe.likes_coun_by_model(User)
    # => 1
    def likes_count_by_model(model)
      self.likes_assoc.where(:like_type => model.to_s).count
    end

    # view all selfs likes
    #
    # Example:
    # => @joe.all_likes
    # => [@track]
    def all_likes
      get_likes_of(self)
    end

    # view all selfs likes by model
    #
    # Example:
    # => @joe.all_likes_by_model
    # => [@track]
    def all_likes_by_model(model)
      get_likes_of(self, model)
    end

    # view all common likes of self against model
    #
    # Example:
    # => @joe.common_likes_with(@max)
    # => [@track1, @track2]
    def common_likes_with(model)
      model_likes = get_likes_of(model)
      self_likes = get_likes_of(self)

      self_likes & model_likes
    end

    private
    def get_likes_of(me, model = nil)
      likes = !model ? me.likes_assoc : me.likes_assoc.where(:like_type => model.to_s)

      likes.collect do |like|
        like.like_type.constantize.find(like.like_id)
      end
    end

    def method_missing(missing_method, *args, &block)
      if missing_method.to_s =~ /^(.+)_likes_count$/
        likes_count_by_model($1.camelize)
      elsif missing_method.to_s =~ /^all_(.+)_likes$/
        all_likes_by_model($1.camelize)
      else
        super
      end
    end
  end
end
