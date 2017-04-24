class AvatarUploader < CarrierWave::Uploader::Base

  # require 'carrierwave/processing/mini_magick'
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick   # This lets you create different versions of an image (i.e. a thumbnail)

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.userKey}"
  end

  # def cache_dir
  #   "#{Rails.root}/tmp/uploads"
  # end
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # process :resize_to_fill => [200, 200]
   
  #version :resized do
    # returns an image with a maximum width of 100px 
    # while maintaining the aspect ratio
    # 10000 is used to tell CW that the height is free 
    # and so that it will hit the 100 px width first
  #  process :resize_to_fit => [200, 200]
  #end

  # Process files as they are uploaded:
  # process scale(200, 200)

  # def scale(width, height)
  #   resize_to_fit width, height
  # end
  # process :resize_to_fill => [200, 200]

  # Create different versions of your uploaded files: # need to include MiniMagik
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
