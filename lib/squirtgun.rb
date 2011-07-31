class Squirtgun
  require 'socket'

  def report(message)
    # TODO: add message format testing?  Guzzler currenlty expects [context]:[value]
    sock = UDPSocket.new

    # TODO: need an environment variable for this value
    sock.send(message, 0, '174.143.25.227', 43278)
    sock.close
  end
end