class Squirtgun
  require 'socket'

  def report(options={})
    return if options[:context].nil? or options[:value].nil?

    # TODO: add message format testing?  Guzzler currenlty expects [context]:[value]
    sock = UDPSocket.new
    # TODO: need an environment variable for these values
    sock.send({:stat => options}.to_json, 0, '174.143.25.227', 43278)
    sock.close
  end
end