# encoding: UTF-8
require_relative '../spec_helper'

describe Artoo::Drivers::Wandboard do

    let(:driver) { Artoo::Drivers::Wandboard.new }

    it '#start_driver' do
        expect {  driver.start_driver }.to_not raise_error
    end

end
