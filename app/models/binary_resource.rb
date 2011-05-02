class BinaryResource < ActiveRecord::Base
  has_attached_file(:file, CMS_FILE_STORE_OPTIONS)
end
