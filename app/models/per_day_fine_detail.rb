class PerDayFineDetail < ActiveRecord::Base
	validates :fine_per_day ,presence:true, numericality: {only_integer:true, greater_than:0}
end
