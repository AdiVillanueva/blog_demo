module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    include SanitizableSql

    def filter(filtering_params, order_by = nil)
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", sanitize_sql(value)) if value.present?
      end
      results = results.public_send("filter_order_by", order_by) if order_by.present?
      results
    end
  end
end
