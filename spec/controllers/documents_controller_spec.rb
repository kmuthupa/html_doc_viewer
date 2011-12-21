require 'spec_helper'

describe DocumentsController do
  render_views
  
  it 'return a new upload page with success when service is available' do
    RestClient.stub!(:get).and_return("hello world") if STUB_CONVERSION
    get :new
    response.should be_success
    response.should render_template(:new)
    assigns(:service_available).should be_true
  end
  
  it 'return a new upload page with exception when service is not available' do
    RestClient.stub!(:get).and_return("not found") if STUB_CONVERSION
    get :new
    response.should be_success
    response.should render_template(:new)
    assigns(:service_available).should be_false
  end
  
  it 'return the upload result page with success' do
    get :result
    response.should be_success
    response.should render_template(:result)
  end
  
  it 'return the document display page with success' do
    get :display, {:doc_name => 'test.pdf', :pages => '4', :loc => '1ef18bea-2d6f-408e-a742-3ddbd8c1d69e'}
    response.should be_success
    response.should render_template(:display)
    response.body.include?('Jump to Page').should be_true
    assigns(:doc_name).should == 'test'
    assigns(:pages).should == 4
    assigns(:loc).should == '1ef18bea-2d6f-408e-a742-3ddbd8c1d69e'
  end
  
  it 'return the document display page with exception' do
    get :display, {:doc_name => 'test.pdf', :pages => '0', :loc => '1ef18bea-2d6f-408e-a742-3ddbd8c1d69e'}
    response.should be_success
    response.should render_template(:display)
    response.body.include?('Sorry').should be_true
    assigns(:doc_name).should == 'test'
    assigns(:pages).should == 0
    assigns(:loc).should == '1ef18bea-2d6f-408e-a742-3ddbd8c1d69e'
  end
  
  it 'fetches the page using the URL with success' do
    get :fetch, {:fetch_url => 'http://test.host/422.html'}
    response.should be_success
  end
  
  describe 'upload' do
    before(:each) do
      @test_document = fixture_file_upload('/test.pdf', 'application/pdf')
      class << @test_document #hack to simulate the file upload action
         attr_reader :tempfile
      end
    end
    
    it 'should not upload or process without a file to the server' do
      post :upload
      response.should be_success
      response.should render_template(:new)
      assigns(:doc_name).should be_nil
    end
    
    it 'should upload a file to the server with success and process it successfully' do
      RestClient.stub!(:post).and_return(StubResponse.new(200)) if STUB_CONVERSION
      post :upload, {:document_file => @test_document}
      response.should be_success
      response.should render_template(:result)
      assigns(:doc_name).should == 'test.pdf'
      assigns(:conversion_response).code.should == 200
    end
    
    it 'should upload a file to the server with success and fail processing it' do
      RestClient.stub!(:post).and_return(StubResponse.new(500))
      post :upload, {:document_file => @test_document}
      response.should be_success
      response.should render_template(:result)
      assigns(:doc_name).should be_nil
      assigns(:conversion_response).code.should == 500
      assigns(:pages).should be_nil
      assigns(:loc).should be_nil
    end
    
    describe 'upload of file with spaced file name' do
      before(:each) do
        @test_document = fixture_file_upload('/Sivasankari Ranganathan.pdf', 'application/pdf')
        class << @test_document #hack to simulate the file upload action
           attr_reader :tempfile
        end
      end
      
       it 'should upload a file to the server with success and process it successfully' do
          RestClient.stub!(:post).and_return(StubResponse.new(200)) if STUB_CONVERSION
          post :upload, {:document_file => @test_document}
          response.should be_success
          response.should render_template(:result)
          assigns(:doc_name).should == 'SivasankariRanganathan.pdf'
          assigns(:conversion_response).code.should == 200
        end
    end
  end
end

class StubResponse
  attr_reader :code
  def initialize(resp_code)
    @code = resp_code
  end
end
