RSpec.describe 'POST /users/sign_in', type: :request do
  let(:user) { build(:user) }
  let!(:account) { create(:account_with_schema, owner: user) }
  let(:url) { '/users/sign_in.json' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: 'password'
      }
    }
  end

  before { host! "#{account.subdomain}.example.com" }

  context 'when params are correct' do
    before do
      post url, params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end
  end

  context 'when /users/sign_in params are incorrect' do
    before { post url }
    
    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /sign_out', type: :request do
  let(:user) { build(:user) }
  let!(:account) { create(:account_with_schema, owner: user) }
  let(:url) { '/users/sign_out.json' }

  before { host! "#{account.subdomain}.example.com" }

  it 'returns 204, no content' do
    get url
    expect(response).to have_http_status(204)
  end
end
