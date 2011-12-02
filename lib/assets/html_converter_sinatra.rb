require 'sinatra'
require 'fileutils'
require 'uuidtools'

set :public_folder, '/home/kmuthupa/projects/html_converter'

post '/:filename' do
  # write the file to the file system
  unique_id = UUIDTools::UUID.random_create.to_s
  save_dir = "/home/kmuthupa/projects/html_converter/#{unique_id}"
  FileUtils.mkdir_p(save_dir)
  filename = File.join(save_dir, params[:filename])
  datafile = params[:data]
  File.open(filename, 'wb') do |f|
    f.write(datafile[:tempfile].read)
  end
  
  # invoke pdftohtml to convert the pdf to html
  begin
    `/home/kmuthupa/projects/pdftohtml-2/utils/pdftohtml -c -linksOutGoToNewWindow -cropbox -fmt jpg -dpi 16 -zoom 24 -scale 0.0416666666666667 -embedfonts -extractfonts "#{filename}"`
    # send success response back to client
    [200, "/#{unique_id}/#{params[:filename]}"]
  rescue
    # send failure response back to client
    [500, "The conversion for #{params[:filename]} failed due to reasons unknown."]
  end
end

get '/' do
  "hello world"
end