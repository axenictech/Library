class OtherLibrarySetting < ActiveRecord::Base
validates :fine_per_day ,presence:true
validates :times_renew_book ,presence:true
end