class GoalsSweeper < ActionController::Caching::Sweeper
  observe Goal
  
  def after_save(goal)
    puts __method__.to_s
    expire_cache(goal)
  end

  def after_update(goal)
    puts __method__.to_s
    expire_cache(goal)
  end
  
  def after_destroy(goal)
    puts __method__.to_s
    expire_cache(goal)
  end
  
  def expire_cache(goal)
    puts "Expiring goal cache..."
    # expire_action :controller => :goals, :action => :index
  end
end