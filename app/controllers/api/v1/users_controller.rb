module Api
  module V1
    class UsersController < BaseController
      skip_before_action :verify_authenticity_token

      def filter
        users = if (campaign_names = params[:campaign_names]&.split(','))
                  User.by_campaign_names(campaign_names)
                else
                  User.all
                end

        render_success(:ok, users)
      end

      private

      def new_resource
        @new_resource ||= User.new(user_params)
      end

      def resources
        @resources ||= User.all
      end

      def user_params
        user_params = params.require(:user).permit(:name, :email)

        if params[:user][:campaigns_list]
          user_params[:campaigns_list] = begin
            JSON.parse(params[:user][:campaigns_list])
          rescue StandardError
            []
          end
        end

        @user_params ||= user_params
      end
    end
  end
end
