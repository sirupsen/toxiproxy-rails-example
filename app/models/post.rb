class Post < ActiveRecord::Base
  def tags
    TagRedis.smembers(tag_key)
  rescue Redis::CannotConnectError
    []
  end

  def add_tag(tag)
    TagRedis.sadd(tag_key, tag)
  end

  def remove_tag(tag)
    TagRedis.srem(tag_key, tag)
  end

  def tag_key
    "post:tags:#{self.id}"
  end
end
