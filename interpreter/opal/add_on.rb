module JSUtils
  def initialize
    @codemirror = []
  end

  def self.device
    `window`
  end

  def self.document
    `$(document)`
  end

  # time operation
  def self.add_interval(interval)
    @project_intervals << interval
  end

  def self.clear_interval(params)
    `clearInterval(#{params[1]})`
  end

  def self.clear_intervals
    @project_intervals.each do |interval|
      ` clearInterval(#{interval})`
    end
    @project_intervals = []
  end

  def self.add_timeout(timeout)
    @project_timeouts << timeout
  end

  def self.clear_timeout(params)
    `clearTimeout(#{params[1]})`
  end

  def self.clear_timeouts
    @project_timeouts.each do |timeout|
      `clearTimeout(#{timeout})`
    end
    @project_timeouts = []
  end

  def self.verification(*params)
    `atome.jsVerification(#{params})`
  end
end
