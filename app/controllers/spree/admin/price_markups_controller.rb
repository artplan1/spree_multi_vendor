module Spree
  module Admin
    class PriceMarkupsController < ResourceController
      belongs_to 'spree/vendor'

      skip_before_action :load_resource, only: [:edit, :update, :destroy]

      before_action :find_price_markup, only: [:destroy, :edit, :update]

      private

      def collection_url
        edit_admin_vendor_url(@price_markup.vendor)
      end

      def find_price_markup
        # Need to assign to @object here to keep ResourceController happy
        @price_markup = @object = parent.price_markups.find(params[:id])
      end

      # Override method used to create a new instance to correctly
      # associate adjustment with order
      def build_resource
        parent.price_markups.build(vendor: parent)
      end
    end
  end
end
