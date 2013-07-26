require 'carrierwave/processing/mini_magick'
         # require 'carrierwave/processing/mime_types'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # include CarrierWave::MimeTypes
  # process :set_content_type
  IMAGE_EXTENSIONS = %w(jpg jpeg gif png)
  DOCUMENT_EXTENSIONS = %w(exe pdf doc docm xls docx)
  
  def store_dir
    "files/#{model.id}"
  end
 
  def cache_dir
    "#{::Rails.root.to_s}/tmp/uploads" 
  end
 
  def extension_white_list
    IMAGE_EXTENSIONS + DOCUMENT_EXTENSIONS
  end
 
  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
 
  # create a new "process_extensions" method.  It is like "process", except
  # it takes an array of extensions as the first parameter, and registers
  # a trampoline method which checks the extension before invocation
  def self.process_extensions(*args)
    extensions = args.shift
    args.each do |arg|
      if arg.is_a?(Hash)
        arg.each do |method, args|
          processors.push([:process_trampoline, [extensions, method, args]])
        end
      else
        processors.push([:process_trampoline, [extensions, arg, []]])
      end
    end
  end
 
  # our trampoline method which only performs processing if the extension matches
  def process_trampoline(extensions, method, args)
    extension = File.extname(original_filename).downcase
    extension = extension[1..-1] if extension[0,1] == '.'
    self.send(method, *args) if extensions.include?(extension)
  end
  
  # version actually defines a class method with the given block
  # therefore this code does not run in the context of an object instance  
  # and we cannot access uploader instance fields from this block
  version :top do
    process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [910,1800]
  end
 
  version :logo do
    process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [210,100]
  end
  
  version :gallery do
    process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fill => [152,114]
  end
  
  version :side do
    process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [455,1800]
  end
 
  version :preview do
    process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fit => [120, 1800]
  end
  
  version :thumb do
    process_extensions ImageUploader::IMAGE_EXTENSIONS, :resize_to_fill => [35, 35]
  end
end