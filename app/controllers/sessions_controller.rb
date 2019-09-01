class SessionsController < Devise::SessionsController
  respond_to :html, :json

  private

  def respond_with(resource, _opts = {})
    respond_to do |format|
      format.html{ super(resource, _opts) }
      format.json do
        render json: resource, headers: {'Authorization':'aaaaaaa'}
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
