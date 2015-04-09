class HomeController < ApplicationController
  def index
    @projects = Project.all
  end

  def addproject
  end

  def createproject
    # Make an object in your bucket for your upload
    service = AWS::S3.new(:access_key_id => ACCESS_KEY_ID,
                          :secret_access_key => SECRET_ACCESS_KEY)
    bucket_name = "personalsitedrewgarcia"
    if(service.buckets.include?(bucket_name))
      bucket = service.buckets[bucket_name]
    else
      bucket = service.buckets.create(bucket_name)
    end
    bucket.acl = :public_read
    key = folder_name.to_s + "/" + File.basename(image_location)
    s3_file = service.buckets[bucket_name].objects[key].write(:file => image_location)
    s3_file.acl = :public_read
    user = User.where(id: user_id).first
    user.image = s3_file.public_url.to_s
    user.save

  end
end
