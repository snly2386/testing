require 'aws-sdk-v1'
class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @projects = Project.all
  end

  def addproject
  end

  def createproject
    # The image uploading to S3
    if params[:fileToUpload] != nil
     AWS.config(
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'])
      bucket_name = 'hiremeremote'
      photo_path = params[:fileToUpload]
      s3 = AWS::S3.new
      key = photo_path.original_filename
      image = s3.buckets[bucket_name].objects[key].write(:file => photo_path)
      puts "Uploading file #{photo_path} to bucket #{bucket_name}."
      doomsday = Time.mktime(2038, 1, 18).to_i
      image.public_url(:expires => doomsday)
      url_string = image.public_url.to_s
      session[:picurl] = url_string
      @picurl = session[:picurl]
    end

    @theTitle = params[:ptitle]
    @theCategory = params[:pcategory]
    @theAbout = params[:pabout]
    @theURL = params[:purl]

    @theProject = Project.new

    @theProject.title = @theTitle
    @theProject.category = @theCategory
    @theProject.about = @theAbout
    @theProject.image_url = @picurl
    @theProject.theurl = @theURL

    @theProject.save
  end

  def singleportfolio
    @theProject = Project.find(params[:id])
  end

  def submitcontactform
    UserMailer.welcome_email(params[:cname], params[:cmessage], params[:cemail]).deliver_now
    respond_to do |format|
      format.html {redirect_to root_url}
      format.json {}
    end
  end
end
