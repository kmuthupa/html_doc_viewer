class DocumentsController < ApplicationController
  def new
  end
  
  def upload
    if params[:document_file] && File.exists?(params[:document_file].tempfile)
      # persist the file
      file_name = params[:document_file].original_filename
      save_file = File.new("#{Rails.root}/tmp/uploads/#{file_name}", 'w')
      File.open(params[:document_file].tempfile, 'r') do |f|
        save_file.write(f.read)
      end
      save_file.close
      save_file_name = File.basename(save_file.path)
      # upload the file to the sinatra conversion service
      begin
        @conversion_response = RestClient.post "http://172.16.240.136:4567/#{save_file_name}", :data => File.new("#{save_file.path}")       
      rescue
        raise 'conversion service is unavailable at the moment!'
      end
    end
    @doc_name = save_file_name if @conversion_response.code == 200
    respond_to do |format|
      format.html {render :action => 'result'}
    end
  end
  
  def result
  end
  
  def display
  end
end
