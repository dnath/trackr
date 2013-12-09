class GoalInstancesSweeper < ActionController::Caching::Sweeper
  observe GoalInstance
  
  def after_save(goal_instance)
    puts __method__.to_s
    expire_cache(goal_instance)
  end

  def after_update(goal_instance)
    puts __method__.to_s
    expire_cache(goal_instance)
  end
  
  def after_destroy(goal_instance)
    puts __method__.to_s
    expire_cache(goal_instance)
  end
  
  def expire_cache(goal_instance)
    puts "Expiring goal instances cache..." 
    r = Regexp.new("views/.+/goal_instances.*")
    puts "r = " + r.to_s
    expire_fragment(r) 
  end
end 