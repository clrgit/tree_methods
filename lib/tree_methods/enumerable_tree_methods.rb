module EnumerableTreeMethods
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




