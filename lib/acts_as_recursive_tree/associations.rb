# frozen_string_literal: true

require 'active_support/concern'

module ActsAsRecursiveTree
  module Associations
    extend ActiveSupport::Concern

    included do
      polymorphic = _recursive_tree_config.parent_type_column.present?
      options = {
        class_name: base_class.to_s,
        foreign_key: _recursive_tree_config.parent_key,
        inverse_of: :children,
        optional: true,
        polymorphic: polymorphic
      }

      # Only add foreign_type if polymorphic, otherwise belongs_to will complain
      options[:foreign_type] = _recursive_tree_config.parent_type_column if polymorphic

      belongs_to :parent, **options

      has_many :children,
               class_name: base_class.to_s,
               foreign_key: _recursive_tree_config.parent_key,
               inverse_of: :parent,
               dependent: _recursive_tree_config.dependent

      if polymorphic
        def self_and_siblings
          pkey = _recursive_tree_config.parent_key
          base_class.where(pkey => send(pkey))
        end
      else
        has_many :self_and_siblings,
                 through: :parent,
                 source: :children,
                 class_name: base_class.to_s
      end
    end
  end
end
