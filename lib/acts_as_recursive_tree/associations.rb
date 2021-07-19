require 'active_support/concern'

module ActsAsRecursiveTree
  module Associations
    extend ActiveSupport::Concern

    included do
      polymorphic = !!self._recursive_tree_config.parent_type_column
      belongs_to :parent,
                 class_name:  self.base_class.to_s,
                 foreign_key: self._recursive_tree_config.parent_key,
                 inverse_of:  :children,
                 optional:    true,
                 polymorphic: polymorphic,
                 foreign_type: self._recursive_tree_config.parent_type_column

      has_many :children,
               class_name:  self.base_class.to_s,
               foreign_key: self._recursive_tree_config.parent_key,
               inverse_of:  :parent

      if polymorphic
        def self_and_siblings
          pkey = self._recursive_tree_config.parent_key
          self.base_class.where(pkey => self.send(pkey))
        end
      else
        has_many :self_and_siblings,
                 through: :parent,
                 source: :children,
                 class_name:  self.base_class.to_s
      end
    end
  end
end
