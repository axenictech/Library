class Tag < ActiveRecord::Base

	has_many :books_tag

	def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end
end

