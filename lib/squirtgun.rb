class Squirtgun
  require 'socket'

  def report(options={})
    return if options[:event].nil? or options[:value].nil?

    # TODO: send this as JSON
    message = "#{options[:event]}:#{options[:value]}"

    # TODO: add message format testing?  Guzzler currenlty expects [context]:[value]
    sock = UDPSocket.new
    # TODO: need an environment variable for these values
    sock.send(message, 0, '174.143.25.227', 43278)
    sock.close
  end
end