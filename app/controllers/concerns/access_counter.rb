module AccessCounter extend ActiveSupport::Concern
  def increase_times
    @access_times = session[:access_times]
    if @access_times.nil?
      @access_times = 0
    end
    @access_times += 1
    session[:access_times] = @access_times
  end

  def reset_times
    @access_times = 0
    session[:access_times] = @access_times
  end
end
