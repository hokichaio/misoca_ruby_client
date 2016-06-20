require 'spec_helper'

describe MisocaRubyClient do
  it 'has a version number' do
    expect(MisocaRubyClient::VERSION).not_to be nil
  end
  it 'does not raise error' do
    expect{ MisocaRubyClient::Client.new("a", "b", "c") }.to_not raise_error
  end
end
