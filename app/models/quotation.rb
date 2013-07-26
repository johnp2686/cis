class Quotation < ActiveRecord::Base
  attr_accessible :quotation
  mount_uploader :quotation, QuotationUploader
end
