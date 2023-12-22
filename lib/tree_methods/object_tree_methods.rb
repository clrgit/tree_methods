module ObjectTreeMethods
  def follow(include_self = false, &block) 
    result = include_self ? [self] : []
    follow_implementation(result, &block)
    result
  end

private
  def follow_implementation(result, &block)
    if follower = block.call(self)
      result << follower
      follower.send(:follow_implementation, result, &block)
    end
  end
end

