# frozen_string_literal: true

require "rails_helper"

describe ProcessOrderService do
  describe "#call" do
    let(:processed_order_v2) { JSON.parse(File.read("spec/fixtures/processed_order_v2.json")) }
    let(:url) { ENV['API_URL'] + '/auth/get_token' }
    let(:response) { HTTParty.get(url) }

    describe "when it succeeds" do
      it "returns true" do
        expect(subject.send(:call, processed_order_v2, response['token'])).to be(true)
      end
    end

    describe "when it fails" do
      it "returns false" do
        expect(subject.send(:call, processed_order_v2, nil)).to be(false)
      end
    end
  end
end
