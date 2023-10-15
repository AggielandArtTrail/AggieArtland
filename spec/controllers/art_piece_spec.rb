require 'rails_helper'

RSpec.describe ArtPiecesController, type: :controller do
  
  describe 'GET #index' do
    it 'assigns all art pieces to @art_pieces' do
      art_piece1 = FactoryBot.create(:art_piece)
      art_piece2 = FactoryBot.create(:art_piece)

      get :index

      expect(assigns(:art_pieces)).to eq([art_piece1, art_piece2])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:art_piece) { FactoryBot.create(:art_piece) }

    it 'assigns the requested art piece to @art_piece' do
      get :show, params: { id: art_piece.id }

      expect(assigns(:art_piece)).to eq(art_piece)
    end

    it 'renders the show template' do
      get :show, params: { id: art_piece.id }

      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new art piece to @art_piece' do
      get :new

      expect(assigns(:art_piece)).to be_a_new(ArtPiece)
    end

    it 'renders the new template' do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { FactoryBot.attributes_for(:art_piece) }

      it 'creates a new art piece' do
        expect {
          post :create, params: { art_piece: valid_params }
        }.to change(ArtPiece, :count).by(1)
      end

      it 'redirects to the created art piece' do
        post :create, params: { art_piece: valid_params }

        expect(response).to redirect_to(art_piece_url(assigns(:art_piece)))
      end
    end
  end

  describe 'PATCH #update' do
    let(:art_piece) { FactoryBot.create(:art_piece) }

    context 'with valid parameters' do
      let(:valid_params) { FactoryBot.attributes_for(:art_piece) }

      it 'updates the requested art piece' do
        patch :update, params: { id: art_piece.id, art_piece: valid_params }

        art_piece.reload
        expect(art_piece.name).to eq(valid_params[:name])
      end

      it 'redirects to the updated art piece' do
        patch :update, params: { id: art_piece.id, art_piece: valid_params }

        expect(response).to redirect_to(art_piece_url(art_piece))
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { FactoryBot.attributes_for(:art_piece, name:nil) }
      
      it "does not update the requested art piece" do
        patch :update, params: { id: art_piece.id, art_piece: invalid_params }
        
        art_piece.reload
        expect(art_piece.name).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:art_piece) { FactoryBot.create(:art_piece) }

    it 'destroys the requested art piece' do
      expect {
        delete :destroy, params: { id: art_piece.id }
      }.to change(ArtPiece, :count).by(-1)
    end
  end


  
  describe 'Admin user' do
    let(:admin_user) { FactoryBot.create(:admin_user) }
    let(:user) { FactoryBot.create(:user) }
    let(:art_piece) { FactoryBot.create(:art_piece) }
    
    context 'when logged in as admin' do
      before do
        # Simulate authentication by setting a user_id in the session
        session[:user_id] = admin_user.id
      end

      it 'assigns the requested art piece to @art_piece' do
        get :edit, params: { id: art_piece.id }
        expect(assigns(:art_piece)).to eq(art_piece)
      end
    
      # it 'renders the admin page' do
      #   get :admin
      #   expect(response).to render_template(:admin)
      # end
      it 'renders the edit template' do
        get :edit, params: { id: art_piece.id }

        expect(response).to render_template(:edit)
      end
    end

    # context 'when not logged in as admin' do
    #   before do
    #     # Simulate authentication by setting a user_id in the session
    #     session[:user_id] = user.id
    #   end
    
    #   # it 'redirects to the login page' do
    #   #   get :admin
    #   #   expect(response).to redirect_to(login_path)
    #   # end
    
    #   # it 'sets a flash error message' do
    #   #   get :admin
    #   #   expect(flash[:error]).to be_present
    #   # end
    #   it 'redirects to the show art piece page' do
    #     get :edit, params: { id: art_piece.id }
    #     expect(response).to redirect_to(show_art_piece_path)
    #   end
    
    #   it 'sets an not-allowed flash error message' do
    #     get :edit, params: { id: art_piece.id }
    #     # expect(flash[:error]).to be_present
    #     expect(flash[:notice]).to match(/You do not have the required permissions to edit art pieces./)
    #   end
    # end
  end
end