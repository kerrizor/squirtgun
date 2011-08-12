module Squirtgun
  require 'yaml'

  # TODO: Read these values in from /config/squirtgun.yml
  LISTENER      = '174.143.25.227'
  LISTENER_PORT = '43278'
  SECRET_KEY    = 'johnsmom'

  # TODO: decide if this is a shitty name because its all Squirtgun::Squirtgun..
  class Gun
    require 'socket'
    require 'openssl'

    def report(options={})
      return if options[:context].nil? or options[:value].nil?


      # TODO: add message format testing?  Guzzler currenlty expects [context]:[value]..

      sock = UDPSocket.new
      sock.send({:stat => options, :hmac => encode_packet(options[:context] + options[:value], Squirt::SECRET_KEY)}.to_json, 0, Squirt::LISTENER, Squirt::LISTENER_PORT)
      sock.close
    end

    private
      def encode_packet(data, key)
        OpenSSL::HMAC.hexdigest('sha1', key, data)
      end
  end
end