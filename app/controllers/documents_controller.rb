class DocumentsController < ApplicationController
  def new
  end
  
  def upload
    if params[:document_file] && File.exists?(params[:document_file].tempfile)
      File.open(params[:document_file].tempfile, 'r') do |f|
        file_content = f.read
      end
    end
    respond_to do |format|
      format.html {render :action => 'result'}
    end
  end
  
  def result
  end
end
