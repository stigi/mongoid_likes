require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Mongoid::Likes do
  describe User do
    before :all do
      @joe = User.create(name: 'Joe')
      @max = User.create(name: 'Max')
    end

    it "should have no likes" do
      [@joe, @max].each {|u| u.all_likes.should be_empty}
    end

    describe Track do
      before :all do
        @track1 = Track.create
        @track2 = Track.create
      end

      it "should have no likers" do
        [@track1, @track2].each { |t| t.all_likers.should be_empty }
      end

      it "should be likeable" do
        @joe.like(@track1)
      end

      it "should be liked by liker" do
        @track1.liker?(@joe).should be_true
      end

      it "should not be liked by others" do
        @track1.liker?(@max).should_not be_true
      end

      it "should have the liker as liker" do
        @track1.all_likers.should include @joe
      end

      it "should not have others as liker" do
        @track1.all_likers.should_not include @max
      end

      it "should be likeable by multiple likers" do
        @max.like(@track1)
      end

      it "should be liked by multiple likers" do
        @track1.all_likers.should include @joe, @max
      end

      it "should have the correct likers count" do
        @track1.likers_count.should be 2
        @max.likes_count.should be 1
        @joe.likes_count.should be 1
      end

      it "should be unlikable" do
        @max.unlike(@track1)
      end

      it "should not include former liker" do
        @track1.all_likers.should_not include @max
      end

      it "should not be included in former likes" do
        @max.all_likes.should_not include @track1
      end
    end
  end
end