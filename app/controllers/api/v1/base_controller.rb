module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rescue_from ActionController::ParameterMissing, with: :missing_parameter

      def index
        render_success(:ok, resources)
      end

      def create
        if new_resource.save
          render_success(:created, new_resource)
        else
          render_errors(:unprocessable_entity, new_resource.errors)
        end
      end

      def render_errors(status, errors = [])
        render(json: errors, status: status)
      end

      def render_success(status, resource = {})
        render(json: resource, status: status)
      end

      private

      # these method need to be overridden
      def new_resource; end
      def resources; end

      def record_not_found(error)
        render_errors(:not_found, error.message)
      end

      def missing_parameter(error)
        render_errors(:unprocessable_entity, error.message)
      end
    end
  end
end
