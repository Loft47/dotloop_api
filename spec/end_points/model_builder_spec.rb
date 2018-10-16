require 'spec_helper'

describe DotloopApi::EndPoints::ModelBuilder do
  subject { subject_class.new }
  let(:subject_class) { Class.new { include DotloopApi::EndPoints::ModelBuilder } }
  let(:folder) do
    {
      'id' => 1234,
      'documents' => [{ 'id' => 1, 'name' => 'OfferToPurchase' }, { 'id' => 2, 'name' => 'CommissionDisclosure' }]
    }
  end
  let(:detail) do
    {
      'financials' => { 'purchase/sale price' => '200000' },
      'contract dates' => { 'closing date' => '10/18/2019' },
      'property address' => {
        'country' => 'USA', 'street number' => '456', 'street name' => 'Old Moat Lane', 'mls #' => '555-111-222'
      }
    }
  end

  describe '#build_model' do
    let(:subject_class) do
      Class.new do
        include DotloopApi::EndPoints::ModelBuilder
        def initialize
          @type = DotloopApi::Models::Profile::Loop::Folder
          @client = :client
          @profile_id = 88
          @loop_id = 99
        end
      end
    end
    it '#build_build_model' do
      result = subject.build_model(folder)
      expect(result).to be_a(DotloopApi::Models::Profile::Loop::Folder)
      expect(result.documents).to all(be_a(DotloopApi::Models::Profile::Loop::Folder::Document))
      expect(result.client).to eq :client
      expect(result.profile_id).to eq 88
      expect(result.loop_id).to eq 99
    end
  end

  describe 'folder' do
    it '#build_documents' do
      result = subject.build_documents(folder)
      expect(result).to all(be_a(DotloopApi::Models::Profile::Loop::Folder::Document))
    end
  end

  describe 'detail' do
    it '#build_details' do
      result = subject.build_details(detail)
      expect(result.keys).to include(:property_address, :financials, :contract_dates)
      expect(result[:property_address]).to be_a DotloopApi::Models::Profile::Loop::Detail::PropertyAddress
      expect(result[:property_address][:mls_number]).to eq '555-111-222'
    end
  end
end
