class Url < ActiveRecord::Base
	validates :url, :presence => true
	validates :url, :uniqueness => true

	default_scope -> {order( 'created_at DESC' )}
end
