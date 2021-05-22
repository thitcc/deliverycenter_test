# frozen_string_literal: true

require "rails_helper"

describe Api::V2::OrdersController, type: :request do
  describe "POST #create" do
    let(:process_service) { instance_spy(ProcessOrderService) }

    context "when it succeeds" do
      let(:params) { JSON.parse(File.read("spec/fixtures/raw_order.json")).deep_symbolize_keys }

      before do
        allow(process_service).to receive(:call).and_return(true)

        post api_v2_orders_path, params: params
      end

      include_examples 'http status code', 404

      it "create new order" do
        expect(Order.count).to eq(1)
      end

      it "create new address" do
        expect(Address.count).to eq(1)
      end

      it "create new order items" do
        expect(Item.count).to eq(1)
      end

      it "create new customer" do
        expect(Customer.count).to eq(1)
      end

      it "create new payment" do
        expect(Payment.count).to eq(1)
      end
    end

    context "when it fails validations" do
      let(:params) { {} }

      before { post api_v1_orders_path, params: params }

      include_examples 'http status code', 404

      it "doesnt persists order" do
        expect(Order.count).to eq(0)
      end
    end

    context "when it fails remote request" do
      let(:params) { JSON.parse(File.read("spec/fixtures/raw_order.json")).deep_symbolize_keys }

      before do
        allow_any_instance_of(ProcessOrderService).to receive(:call).and_return(false)

        post api_v2_orders_path, params: params
      end

      include_examples 'http status code', 404
    end
  end
end
