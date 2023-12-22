# frozen_string_literal: true

require_relative "tree_methods/version"

module TreeMethods
  class Error < StandardError; end

  def follow(include_self = false, &block) 
    result = include_self ? [self] : []
    follow_implementation(result, &block)
    result
  end

  def preorder(include_self = true, &block)
    result = include_self ? [self] : []
    preorder_implementation(result, &block)
    result
  end
  
  def postorder(include_self = true, &block)
    result = []
    postorder_implementation(result, &block)
    include_self ? result + [self] : result
  end

private
  def follow_implementation(result, &block)
    if follower = block.call(self)
      result << follower
      follower.send(:follow_implementation, result, &block)
    end
  end

  def preorder_implementation(result, &block)
    block.call(self).each { |node|
      result << node
      node.send(:preorder_implementation, result, &block)
    }
  end

  def postorder_implementation(result, &block)
    block.call(self).each { |node|
      node.send(:postorder_implementation, result, &block)
      result << node
    }
  end
end

class Object
  include TreeMethods # FIXME Whoa!
end

