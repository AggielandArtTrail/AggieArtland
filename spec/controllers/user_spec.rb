require 'rails_helper'

RSpec.describe UsersController, type: :controller do
#   describe 'GET #index' do
#     it 'assigns all users to @users' do
#       user1 = FactoryBot.create(:user)
#       user2 = FactoryBot.create(:user)

#       get :index

#       expect(assigns(:users)).to eq([user1, user2])
#     end

#     it 'renders the index template' do
#       get :index

#       expect(response).to render_template(:index)
#     end
#   end

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }
    
    context 'when logged in' do
      before do
        # Simulate authentication by setting a user_id in the session
        session[:user_id] = user.id
      end
    
      it 'renders the show template' do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    
      it 'assigns the requested user to @user' do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to eq(user)
      end
    end
    
    context 'when not logged in' do
      it 'redirects to the login page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(login_path)
      end
    
      it 'sets a flash error message' do
        get :show, params: { id: user.id }
        expect(flash[:error]).to be_present
      end
    end
  end



  describe 'GET #new' do
    it 'assigns a new user to @user' do
      get :new

      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { FactoryBot.attributes_for(:user) }

      it 'creates a new user' do
        expect {
          post :create, params: { user: valid_params }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the home page' do
        post :create, params: { user: valid_params }

        expect(response).to redirect_to(art_pieces_url)
      end
    end
  end

end