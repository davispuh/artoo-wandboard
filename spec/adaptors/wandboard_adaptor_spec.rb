# encoding: UTF-8
require_relative '../spec_helper'

describe Artoo::Adaptors::Wandboard do

    let(:adaptor) { Artoo::Adaptors::Wandboard.new }
    let(:pin) { double('DigitalPin') }
    let(:i2c) { double('I2C') }

    describe 'device info interface' do
        describe '#name' do
            it 'should return Wandboard name' do
                expect(adaptor.name).to eq('wandboard')
            end
        end

        describe '#version' do
           it 'should return Wandboard adapter version' do
               expect(adaptor.version).to eq(Artoo::Wandboard::VERSION)
           end
        end
    end

    describe 'digital GPIO interface' do
        describe '#connect' do
            it 'should connect to Wandboard hardware' do
                expect(adaptor.connect).to be true
            end
        end

        describe '#disconnect' do
            it 'should disconnect from Wandboard hardware' do
                adaptor.connect
                allow(Artoo::Adaptors::IO::DigitalPin).to receive(:new).with(200, 'r') { pin }
                allow(pin).to receive(:digital_read) { 1 }
                expect(pin).to receive(:close)
                adaptor.digital_read(:JP4_12)
                expect(adaptor.disconnect).to be true
            end
        end

        describe '#digital_read' do
            it 'should read from :JP4_12 pin' do
                adaptor.connect
                expect(Artoo::Adaptors::IO::DigitalPin).to receive(:new).with(200, 'r') { pin }
                allow(pin).to receive(:mode) { 'r' }
                expect(pin).to receive(:digital_read) { 1 }
                expect(adaptor.digital_read(:JP4_12)).to eq(1)
            end

            it 'should raise exception if not connected' do
                expect { adaptor.digital_read(:JP4_8) }.to raise_error('Not connected')
            end

            it 'should raise exception if invalid pin' do
                adaptor.connect
                expect { adaptor.digital_read(:JP4_80) }.to raise_error('Not a valid pin')
            end
        end

        describe '#digital_write' do
            it 'should write to :JP4_8 pin' do
                adaptor.connect
                expect(Artoo::Adaptors::IO::DigitalPin).to receive(:new).with(191, 'w') { pin }
                allow(pin).to receive(:mode) { 'w' }
                expect(pin).to receive(:digital_write).with(1)
                expect(pin).to receive(:digital_write).with(0)
                adaptor.digital_write(:JP4_8, 1)
                adaptor.digital_write(:JP4_8, 0)
            end

            it 'should raise exception if not connected' do
                expect { adaptor.digital_write(:JP4_12, 1) }.to raise_error('Not connected')
            end
        end
    end

    describe 'i2c interface' do
        describe '#i2c1_start' do
            it 'should start /dev/i2c-0 at address 0x50' do
                expect(Artoo::Adaptors::IO::I2c).to receive(:new).with('/dev/i2c-0', 0x50) { i2c }
                expect(adaptor.i2c1_start(0x50)).to be i2c
            end
        end

        describe '#i2c1_read' do
            it 'should read i2c-1' do
                allow(Artoo::Adaptors::IO::I2c).to receive(:new) { i2c }
                adaptor.i2c1_start(0x50)
                expect(i2c).to receive(:read).with(3) { [0x00, 0x01, 0x02] }
                expect(adaptor.i2c1_read(3)).to eq([0x00, 0x01, 0x02])
            end
        end

        describe '#i2c1_write' do
            it 'should write i2c-1' do
                allow(Artoo::Adaptors::IO::I2c).to receive(:new) { i2c }
                adaptor.i2c1_start(0x50)
                expect(i2c).to receive(:write).with(0x00, 0x01, 0x02) { true }
                expect(adaptor.i2c1_write(0x00, 0x01, 0x02)).to be true
            end
        end

        describe '#i2c2_start' do
            it 'should start /dev/i2c-1 at address 0x50' do
                expect(Artoo::Adaptors::IO::I2c).to receive(:new).with('/dev/i2c-1', 0x50) { i2c }
                expect(adaptor.i2c2_start(0x50)).to be i2c
            end
        end

        describe '#i2c2_read' do
            it 'should read i2c-2' do
                allow(Artoo::Adaptors::IO::I2c).to receive(:new) { i2c }
                adaptor.i2c2_start(0x50)
                expect(i2c).to receive(:read).with(3) { [0x00, 0x01, 0x02] }
                expect(adaptor.i2c2_read(3)).to eq([0x00, 0x01, 0x02])
            end
        end

        describe '#i2c2_write' do
            it 'should write i2c-2' do
                allow(Artoo::Adaptors::IO::I2c).to receive(:new) { i2c }
                adaptor.i2c2_start(0x50)
                expect(i2c).to receive(:write).with(0x00, 0x01, 0x02) { true }
                expect(adaptor.i2c2_write(0x00, 0x01, 0x02)).to be true
            end
        end
    end

end
