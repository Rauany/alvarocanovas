
seeds = Seeds.new(:only => 'contents')
seeds.load_data(:override => true)
seeds.save!

seeds = Seeds.new(:key => 'email', :only => 'users')
seeds.load_data(:override => true)
seeds.save!