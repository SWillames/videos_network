require 'rails_helper'
  
RSpec.describe VideosController, type: :controller do
  
  let(:valid_attributes) do
    {title: 'Some text', url: 'vide.m3u8', tag: '#bbb20', tag1: '#texto', tag2:'#texto1', user: create(:user)}
  end

  let(:create_attributes) do
    {title: 'Some text', url: 'vide.m3u8', tag: '#bbb20', tag1: '#texto', tag2:'#texto1', user_id: User.last}
  end

  
  let(:invalid_attributes) do
    {title: '', url: '', user: ''}
  end
  
  let(:valid_session) do
    {email: 'ex@email.com', password: '1234567'}
  end

  describe "GET #index" do
    it "returns a success response" do
      Video.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      video = Video.create! valid_attributes
      get :show, params: {id: video.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      video = Video.create! valid_attributes
      sign_in video.user
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      video = Video.create! valid_attributes
      sign_in video.user
      get :edit, params: {id: video.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "requires a logged-in user" do
        post :create, params: { video: create_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "creates a new Video" do
        user = create(:user)
        sign_in user
        expect {
          post :create, params: {video: create_attributes}, session: valid_session
        }.to change(Video, :count).by(1)
      end

      it "redirects to the created video" do
        video = Video.create valid_attributes
        user = create(:user)
        sign_in user
        post :create, params: { video: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Video.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        user = create(:user)
        sign_in user
        expect{
          post :create, params: {video: invalid_attributes}, 
          session: valid_session}.not_to change(Video, :count)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do 
        { name: 'new name'   }
      end

      it "updates the requested video" do
        video = Video.create! valid_attributes
        sign_in video.user
        put :update, params: {id: video.to_param, video: new_attributes}, session: valid_session
        video.reload
      end

      it "redirects to the video" do
        video = Video.create! valid_attributes
        sign_in video.user
        put :update, params: {id: video.to_param, video: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Video.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        video = Video.create! valid_attributes
        sign_in video.user
        expect {
          put :update, params: {id: video.to_param, video: valid_attributes}, 
          session: valid_session}.not_to change(Video, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested video" do
      video = Video.create! valid_attributes
      sign_in video.user
      expect {
        delete :destroy, params: {id: video.to_param}, session: valid_session
      }.to change(Video, :count).by(-1)
    end

    it "redirects to the videos list" do
      video = Video.create! valid_attributes
      sign_in video.user
      delete :destroy, params: {id: video.to_param}, session: valid_session
      expect(response).to redirect_to(videos_url)
    end
  end
end