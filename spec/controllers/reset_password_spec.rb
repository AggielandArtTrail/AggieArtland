require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do

describe 'POST #forgot' do
    context 'when the email is not present' do
        it 'returns an error response' do
        post :forgot, params: { email: '' }
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Email not present' })
        end
    end

    context 'when the email is valid and a user is found' do
        let(:user) { FactoryBot.create(:user) } # Assuming you have a factory for creating users

        it 'sends a password reset email and returns a success response' do
        post :forgot, params: { email: user.email }
        expect(response).to have_http_status(:ok)
        end
    end

    context 'when the email is not found' do
        it 'returns an error response' do
        post :forgot, params: { email: 'nonexistent@example.com' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ 'error' => ['Email address not found. Please check and try again.'] })
        end
    end

end

describe 'GET #edit' do
 
end

describe 'PATCH #reset' do

end

end