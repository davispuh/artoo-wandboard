require 'artoo/adaptors/adaptor'
require 'artoo/adaptors/io'

module Artoo
  module Adaptors
    # Connect to a wandboard device
    # @see device documentation for more information
    class Wandboard < Adaptor
      attr_reader :device, :pins, :camera, :uart, :spdif, :i2c1, :i2c2, :ttl, :lvds, :spi

      I2C0 = '/dev/i2c-0'
      I2C1 = '/dev/i2c-1'

      def self.gpio(bank, number)
        (bank - 1) * 32 + number
      end

      include Artoo::Adaptors::IO
      PINS = {
               :JP4_4  => gpio(3, 11), #  75
               :JP4_6  => gpio(3, 27), #  91
               :JP4_8  => gpio(6, 31), # 191
               :JP4_10 => gpio(1, 24), #  24
               :JP4_12 => gpio(7,  8), # 200
               :JP4_14 => gpio(3, 26), #  90
               :JP4_16 => gpio(3,  8), #  72
               :JP4_18 => gpio(4,  5), # 101
      }

      # Creates a connection with device
      # @return [Boolean]
      def connect
        @pins ||= {}
        super
      end

      # Closes connection with device
      # @return [Boolean]
      def disconnect
        @pins.each { |n, p| p.close } if @pins
        @pins = {}
        super
      end

      # Name of device
      # @return [String]
      def name
        'wandboard'
      end

      # Version of device
      # @return [String]
      def version
        Artoo::Wandboard::VERSION
      end

      def digital_write(pin, val)
        pin = wandboard_pin(pin, 'w')
        pin.digital_write(val)
      end

      def digital_read(pin)
        pin = wandboard_pin(pin, 'r')
        pin.digital_read
      end

      def i2c1_start(address)
        @i2c1 = I2c.new(I2C0, address)
      end

      def i2c1_write(*data)
        raise 'Not started' unless @i2c1
        @i2c1.write(*data)
      end

      def i2c1_read(len)
        raise 'Not started' unless @i2c1
        @i2c1.read(len)
      end

      def i2c2_start(address)
        @i2c2 = I2c.new(I2C1, address)
      end

      def i2c2_write(*data)
        raise 'Not started' unless @i2c2
        @i2c2.write(*data)
      end

      def i2c2_read(len)
        raise 'Not started' unless @i2c2
        @i2c2.read(len)
      end

      # Uses method missing to call device actions
      # @see device documentation
      def method_missing(method_name, *arguments, &block)
        device.send(method_name, *arguments, &block)
      end

      private

      def translate_pin(pin)
        PINS.fetch(pin)
      rescue KeyError
        raise 'Not a valid pin'
      end

      def wandboard_pin(pin, mode)
        raise 'Not connected' unless connected?
        pin = translate_pin(pin)
        @pins[pin] = DigitalPin.new(pin, mode) if @pins[pin].nil? or @pins[pin].mode != mode
        @pins[pin]
      end

    end
  end
end
