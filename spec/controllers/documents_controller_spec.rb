require 'spec_helper'

describe DocumentsController do
  it 'return a new upload page with success' do
    get :new
    response.should be_success
    response.should render_template(:new)
  end
  
  it 'return the upload result page with success' do
    get :result
    response.should be_success
    response.should render_template(:result)
  end
  
  it 'should upload a file to the server with success' do
    @test_document = fixture_file_upload('/test.pdf', 'application/pdf')
    class << @test_document #hack to simulate the file upload action
       attr_reader :tempfile
    end
    post :upload, {:document_file => @test_document}
    response.should be_success
  end
end
