module Users
  class SessionsController < Devise::SessionsController
    respond_to :html, :json

    def verify_signed_out_user
      respond_to do |format|
        format.html{ super }
        format.json{ }
      end
    end

    private

    def respond_with(resource, _opts = {})
      respond_to do |format|
        format.html{ super(resource, _opts) }
        format.json do
          render json: resource
        end
      end
    end

    def respond_to_on_destroy
      respond_to do |format|
        format.html{ super }
        format.json do
          head :no_content
        end
      end
    end
  end
end
