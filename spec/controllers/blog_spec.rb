require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
    post1 = nil
    post2 = nil
    post3 = nil
    before(:all) do
        BlogPost.destroy_all

        post1 = BlogPost.create( title: "post 1",
                    body: "first!")
        post2 = BlogPost.create( title: "idea",
                    body: "what if we didn't")
        post3 = BlogPost.create( title: "question",
                    body: "where is this damn piece??")
        
    end
    describe 'GET #index' do

      it 'shows the blog' do
        get :index
        expect(response).to render_template(:index)
      end
      it 'contains various blog posts' do
        get :index
        expect(assigns(:blog_posts)).to include(post1,post2,post3)
      end
    end
    

  describe 'GET #show' do
    
    context 'if blog exists' do
      it 'to show a blog post' do
        get :show, params: { id: post1.id }
        expect(response).to render_template(:show)
      end
      it 'to show the right blog post' do
        get :show, params: { id: post1.id }
        expect(assigns(:blog_post)).to eq(post1)
      end
    end
    
    context 'if blog does not exist' do
      it 'redirects to the blog page' do
        get :show, params: { id: 18248124 }
        expect(response).to redirect_to(blogs_path)
      end
    end
  end

    describe 'GET #new' do
    
        context 'when logged in as admin' do
          let(:user) { FactoryBot.create(:admin_user) }
            before do
            session[:user_id] = user.id
            end

            it 'renders new' do
                get :new
                expect(response).to render_template(:new)
            end
        end
        context 'when not logged in as admin' do
          let(:user) { FactoryBot.create(:user) }
            before do
            session[:user_id] = user.id
            end
            it 'redirects to blogs path' do
                get :new
                expect(response).to redirect_to(blogs_path)
            end
        end
    end

    describe 'POST #create' do

      context 'when logged in as admin' do
        let(:user) { FactoryBot.create(:admin_user) }
          before do
          session[:user_id] = user.id
        end
        it 'redirects to blog post' do
            post :create, params: { blog_post: { title: "idk", body: "example body" } }
            expect(response).to redirect_to(blog_path(BlogPost.find_by(title:"idk",body:"example body").id))
        end
      end
      context 'when not logged in as admin' do
        let(:user) { FactoryBot.create(:user) }
          before do
          session[:user_id] = user.id
          end
          it 'redirects ' do
              get :new
              expect(response).to redirect_to(blogs_path)
          end
      end    
    end

    describe 'PUT #update' do
    
      context 'when logged in as admin' do
        let(:user) { FactoryBot.create(:admin_user) }
          before do
          session[:user_id] = user.id
          get :show, params: { id: post3.id }
          end


          it 'redirects to blog post' do
              put :update, params: { id: post3.id, blog_post: { title: "nvm", body: "thanks" } }
              expect(response).to redirect_to(blog_path(BlogPost.find_by(title:"nvm",body:"thanks").id))
          end
              
      end
      context 'when not logged in as admin' do
        let(:user) { FactoryBot.create(:user) }
          before do
          session[:user_id] = user.id
          get :show, params: { id: post3.id }
          end
          it 'redirects ' do
              get :new
              expect(response).to redirect_to(blogs_path)
          end
      end
    end

    describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user) }
        
    context 'when logged in as admin' do
      let(:user) { FactoryBot.create(:admin_user) }
        before do
        session[:user_id] = user.id
        get :show, params: { id: post3.id }
        end

            it 'destroys blog' do
                delete :destroy, params: { id: post3.id }
                expect(BlogPost.all).not_to include(post3)
            end

            it 'redirects to blogs' do
                expect(delete :destroy, params: { id: post3.id }).to redirect_to(blogs_path)
            end
          end

            context 'when not logged in as admin' do
              let(:user) { FactoryBot.create(:user) }
                before do
                session[:user_id] = user.id
                get :show, params: { id: post3.id }
                end
                it 'redirects ' do
                    get :new
                    expect(response).to redirect_to(blogs_path)
                end
            end
    end

end