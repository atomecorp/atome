module JSUtils
  def initialize
    @codemirror = []
  end

  def device
    `window`
  end

  def document
    `$(document)`
  end

  # time operation
  def add_interval(interval)
    @project_intervals << interval
  end

  def clear_interval(params)
    `clearInterval(#{params[1]})`
  end

  def clear_intervals
    @project_intervals.each do |interval|
      ` clearInterval(#{interval})`
    end
    @project_intervals = []
  end

  def add_timeout(timeout)
    @project_timeouts << timeout
  end

  def clear_timeout(params)
    `clearTimeout(#{params[1]})`
  end

  def clear_timeouts
    @project_timeouts.each do |timeout|
      `clearTimeout(#{timeout})`
    end
    @project_timeouts = []
  end

  def verification(*params)
    `atome.jsVerification(#{params})`
  end
end