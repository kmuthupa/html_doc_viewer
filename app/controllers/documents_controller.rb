class DocumentsController < ApplicationController
  before_filter :clear_flash
  
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
      save_file_name = File.basename(save_file.path).gsub(/\s+/, "")
      # upload the file to the sinatra conversion service
      begin
        @conversion_response = RestClient.post "#{CONVERSION_SERVER}/#{save_file_name}", :data => File.new("#{save_file.path}")       
        if @conversion_response.code == 200
          @doc_name = save_file_name 
          #@html_source = @conversion_response.body if @conversion_response.respond_to?(:body)
          @link_to_html = @conversion_response.body.gsub('.pdf', '.html') if @conversion_response.respond_to?(:body)
        end
      rescue Exception => ex
        raise "The conversion service is unavailable or not responding at the moment! Exception info: #{ex.message} #{ex.backtrace.inspect}"
      end
      respond_to do |format|
        format.html {render 'result'}
      end
    else
      flash[:error] = 'No file was chosen!'
      respond_to do |format|
        format.html {render 'new'}
      end
    end
  end
  
  def result
  end
  
  def display
    @link_to_html = params[:html_source].gsub('.pdf', '.html')
    @doc_name = params[:doc_name]
  end
  
  private
  
  def clear_flash
    flash.clear
  end
end
