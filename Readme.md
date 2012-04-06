# Mongoid Likes [![Build Status](https://secure.travis-ci.org/stigi/mongoid_likes.png?branch=master)](http://travis-ci.org/stigi/mongoid_likes)

mongoid_likes allows you to easily add liking ability to you Mongoid documents.


## Installation

Add the following to your Gemfile:

    gem 'mongoid_follow'

If you like living on the edge you can also add:

    gem 'mongoid_likes', :git => 'git://github.com/stigi/mongoid_likes.git', :branch => 'development'


## Requirements

This gem has been tested with [MongoID](http://mongoid.org/) version 2.4.7.


## Usage

Mongoid Likes provides two modules that you can mix in your model objects like that:

    class User
      include Mongoid::Document

      include Mongoid::Liker
    end

    class Track
      include Mongoid::Document

      include Mongoid::Likeable
    end

You can now like objects like this:

    user = User.create
    track = Track.create

    user.like(track)

You can query for likes like that:

    track.all_likers
    # => [user]

    track.likers_count
    # => 1

    user.all_likes
    # => [track]

Also likes are polymorphic, so let's assume you have a second class `Album` that is including `Mongoid::Likeable` you can do something like this:

    album = Album.create
    user.like(album)
    user.all_likes
    # => [track, album]

    user.all_likes_by_model(Album)
    # => [album]

Or even use some convenience methods:

    user.track_likes_count
    # => 1

    user.all_track_likes
    # => [track]

You get the idea. Have a look at the specs to see some more examples.


## Inspiration

Standing on the shoulders of giants:

- [mongoid_follow](https://github.com/alecguintu/mongoid_follow) by [Alec Guintu](https://github.com/alecguintu)  
    You will see that mst of my code comes from this project.
- [mongoid_votable](https://github.com/jcoene/mongoid_voteable) by [Jason Coene](https://github.com/jcoene)  
    Future versions shall aim to go in a similar direction as mongoid_votable.


## TODOs

- write a proper readme
- generate some documentation
- more tests!
- add support for [MongoMapper](http://mongomapper.com/)


## License (MIT)

Copyright (c) 2012 Ullrich Schäfer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.