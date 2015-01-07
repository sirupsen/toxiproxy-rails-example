require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:walrus)
  end

  def teardown
    TagRedis.del(@post.tag_key)
  end

  test "tags are empty by default" do
    assert_equal [], @post.tags
  end

  test "add and list tags" do
    @post.add_tag "mammals"
    @post.add_tag "water"

    assert_equal ["mammals", "water"].sort, @post.tags.sort
  end

  test "add and remove tags" do
    @post.add_tag "mammals"
    @post.add_tag "animals"
    @post.remove_tag "animals"

    assert_equal ["mammals"], @post.tags
  end

  test "should return empty array when tag redis is down when listing tags" do
    @post.add_tag "mammals"

    Toxiproxy[/redis/].down do
      assert_equal [], @post.tags
    end
  end
end
