# encoding: utf-8
require 'carrierwave/processing/mini_magick'

 # require 'carrierwave/processing/mime_types'
class PolicyPhotoUploader < CarrierWave::Uploader::Base
   include CarrierWave::MimeTypes
   # include CarrierWave::MiniMagick
     IMAGE_EXTENSIONS = %w(jpg jpeg gif png)
    DOCUMENT_EXTENSIONS = %w(exe pdf doc docm xls docx)
   # include CarrierWave::RMagick
   # process :set_content_type
  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  # process :resize_to_fill => [200, 200]
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3
 
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
 
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
 
  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
 
  # version :thumb do
  #   process :resize_to_fit => [108, 81]
  # end
 
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    IMAGE_EXTENSIONS + DOCUMENT_EXTENSIONS
end
 
  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end
  #  version :top do
  #   process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [910,1800]
  # end
 
  # version :logo do
  #   process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [210,100]
  # end
  
  # version :gallery do
  #   process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fill => [152,114]
  # end
  
  # version :side do
  #   process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [455,1800]
  # end
 
  # version :preview do
  #   process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [120, 1800]
  # end
  
  # version :thumb do
  #   process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fill => [35, 35]
  # end

end
