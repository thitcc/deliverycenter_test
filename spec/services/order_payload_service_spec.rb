# frozen_string_literal: true

require "rails_helper"

describe OrderPayloadService do
  describe "#call" do
    describe "when it succeeds" do
      let(:raw_order) { JSON.parse(File.read("spec/fixtures/raw_order.json")) }
      let(:processed_order) { JSON.parse(File.read("spec/fixtures/processed_order_v2.json")) }

      it "returns the proccessed payload" do
        payload = JSON.parse(subject.send(:call, raw_order).to_json)

        expect(payload['store_id']).to eq(processed_order['storeId'])
      end
    end

    describe "when it fails" do
      let(:raw_order) { JSON.parse(File.read("spec/fixtures/raw_order.json")).deep_symbolize_keys }

      it "returns an empty hash" do
        expect(subject.send(:call, raw_order)).to be_empty
      end

      describe "within the" do
        let(:raw_order) { JSON.parse(File.read("spec/fixtures/raw_order.json")) }
  
        describe "items block" do
          it "returns items_attributes empty" do
            raw_order['order_items'].first['unit_price'] = []
            
            expect(subject.send(:call, raw_order['items_attributes'])).to be_empty
          end
        end
  
        describe "payments block" do
          it "returns payments_attributes empty" do
            raw_order['payments'].first['payment_type'] = 1

            expect(subject.send(:call, raw_order['payments_attributes'])).to be_empty
          end
        end
      end
    end
  end
end
