require 'rails_helper'
  
RSpec.describe NewsController, type: :controller do
  
  let(:valid_attributes) do
    { title: 'Some text', tldr: 'Some text 123', introduction: 'Some text body 123', 
      slug: 'some-text', body: 'Some text 1234567', url_image: 'www.image.com/image.jpg', 
      date: Time.now, tag: '#fut', tag1: '#braxale', tag2:'#ver', user: create(:user)}
  end

  let(:create_attributes) do
    {title: 'Some text', tldr: 'Some text 123', introduction: 'Some text body 123', 
      slug: 'some-text', body: 'Some text 1234567', url_image: 'www.image.com/image.jpg', 
      tag: '#fut', tag1: '#braxale', tag2:'#ver', user_id: User.last}
  end

  
  let(:invalid_attributes) do
    {title: '', tldr: '', body: '', tag: '#fut', user: ''}
  end
  
  let(:valid_session) do
    {email: 'ex@email.com', password: '1234567'}
  end

  describe "GET #index" do
    it "returns a success response" do
      News.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      news = News.create! valid_attributes
      get :show, params: {id: news.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      news = News.create! valid_attributes
      sign_in news.user
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      news = News.create! valid_attributes
      sign_in news.user
      get :edit, params: {id: news.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "requires a logged-in user" do
        post :create, params: { news: create_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "creates a new News" do
        user = create(:user)
        sign_in user
        expect {
          post :create, params: {news: create_attributes}, session: valid_session
        }.to change(News, :count).by(1)
      end

      it "redirects to the created News" do
        news = News.create valid_attributes
        user = create(:user)
        sign_in user
        post :create, params: { news: valid_attributes }, session: valid_session
        expect(response).to redirect_to(News.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        user = create(:user)
        sign_in user
        expect{
          post :create, params: {news: invalid_attributes}, 
          session: valid_session}.not_to change(News, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do 
        { name: 'new name'   }
      end

      it "updates the requested news" do
        news = News.create! valid_attributes
        sign_in news.user
        put :update, params: {id: news.to_param, news: new_attributes}, session: valid_session
        news.reload
      end

      it "redirects to the news" do
        news = News.create! valid_attributes
        sign_in news.user
        put :update, params: {id: news.to_param, news: valid_attributes}, session: valid_session
        expect(response).to redirect_to(News.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        news = News.create! valid_attributes
        sign_in news.user
        expect {
          put :update, params: {id: news.to_param, news: valid_attributes}, 
          session: valid_session}.not_to change(News, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested news" do
      news = News.create! valid_attributes
      sign_in news.user
      expect {
        delete :destroy, params: {id: news.to_param}, session: valid_session
      }.to change(News, :count).by(-1)
    end

    it "redirects to the videos list" do
      news = News.create! valid_attributes
      sign_in news.user
      delete :destroy, params: {id: news.to_param}, session: valid_session
      expect(response).to redirect_to(news_index_url)
    end
  end
end