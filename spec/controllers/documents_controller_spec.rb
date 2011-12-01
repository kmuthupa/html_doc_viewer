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
end
