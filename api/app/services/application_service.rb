class ApplicationService
  def run
    raise "Not implemented"
  end
  
  private

  def broadcast(channel, payload)
    ActionCable.server.broadcast(channel, payload)
  end
end