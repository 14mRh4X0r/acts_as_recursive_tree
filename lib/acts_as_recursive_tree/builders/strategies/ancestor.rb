# frozen_string_literal: true

module ActsAsRecursiveTree
  module Builders
    module Strategies
      #
      # Strategy for building ancestors relation
      #
      module Ancestor
        #
        # Builds the relation
        #
        def self.build(builder)
          relation = builder.travers_loc_table[builder.parent_key].eq(builder.base_table[builder.primary_key])
          apply_parent_type_column(builder, relation)
        end

        def self.apply_parent_type_column(builder, arel_condition)
          return arel_condition unless builder.parent_type_column.present?
          arel_condition.and(builder.travers_loc_table[builder.parent_type_column].eq(builder.klass.base_class))
        end
      end
    end
  end
end
