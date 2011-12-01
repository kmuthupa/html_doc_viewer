class DocumentsController < ApplicationController
  def new
  end
  
  def upload
    unless params[:document_file].nil?
      file_content = File.read(params[:document_file].tempfile)
    end
    respond_to do |format|
      format.html {render :action => 'result'}
    end
  end
  
  def result
  end
end
