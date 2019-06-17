module Spree
  module Api
    module V1
      class SlideLocationsController < Spree::Api::BaseController
        skip_before_action :load_user
        skip_before_action :authenticate_user

        def show
          @slide_location = SlideLocation.find_by(name: params[:name])

          if @slide_location.nil?
            # NOTE  We need custom handling for when no record is found.
            #       Left to its own devices, this method returns an empty object.
            render "spree/api/errors/not_found", status: 404 and return
          end

          respond_with(@slide_location, status: 201, default_template: :show)
        end
      end
    end
  end
end
