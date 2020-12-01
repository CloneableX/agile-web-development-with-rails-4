module AccessCounter extend ActiveSupport::Concern
  def increase_times
    @access_times = session[:access_times]
    if @access_times.nil?
      @access_times = 0
    end
    session[:access_times] = @access_times + 1
  end
end
