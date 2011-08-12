require 'cattr'
require 'rubygems'
require 'json'

class Squirtgun

  class Config
    cattr_accessor :listener, :listener_port, :secret_key, :project_id

    def self.listener
      @@listener || '174.143.25.227'  # TODO: maybe there's a better way to do defaults?
    end

    def self.listener_port
      @@listener_port || '43278'
    end
  end


  # TODO: decide if this is a shitty name because its all Squirtgun::Squirtgun..
  class Gun
    require 'socket'
    require 'openssl'

    def report(options={})
      return if options[:context].nil? or options[:value].nil?


      # TODO: add message format testing?  Guzzler currenlty expects [context]:[value]..

      options[:project_id] ||= Squirtgun::Config.project_id

      sock = UDPSocket.new
      sock.send({:stat => options, :hmac => encode_packet(options[:context] + options[:value], Squirtgun::Config.secret_key)}.to_json, 0, Squirtgun::Config.listener, Squirtgun::Config.listener_port)
      sock.close
    end

    private
      def encode_packet(data, key)
        OpenSSL::HMAC.hexdigest('sha1', key, data)
      end
  end
end
