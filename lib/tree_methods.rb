# frozen_string_literal: true

require_relative "tree_methods/version"
require_relative "tree_methods/enumerable_tree_methods"
require_relative "tree_methods/object_tree_methods"

module TreeMethods
  class Error < StandardError; end
end

module Enumerable
  include EnumerableTreeMethods # FIXME
end

class Object
  include ObjectTreeMethods # FIXME Whoa!
end

