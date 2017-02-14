require 'ostruct'

module ActsAsRecursiveTree
  module ActsMacro

    ##
    # Configuration options are:
    #
    # * <tt>foreign_key</tt> - specifies the column name to use for tracking
    # of the tree (default: +parent_id+)
    def recursive_tree(parent_key: :parent_id)

      class_attribute :_recursive_tree_config
      self._recursive_tree_config = OpenStruct.new(
          primary_key:  self.primary_key.to_sym,
          parent_key:   parent_key.to_sym,
          depth_column: :recursive_depth
      )
      include ActsAsRecursiveTree::Model
      include ActsAsRecursiveTree::Associations
      include ActsAsRecursiveTree::Scopes
    end

    alias_method :acts_as_tree, :recursive_tree
  end
end