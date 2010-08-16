
seeds = Seeds.new(:only => 'contents')
seeds.load_data(:override => true)
seeds.save!

seeds = Seeds.new(:only => 'users')
seeds.load_data(:key => 'email', :override => true)
seeds.save!