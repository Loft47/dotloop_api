module DotloopApi
  module Models
    class Contact
      ROLE_TYPES = %w[
        ADMIN APPRAISER BUYER BUYER_ATTORNEY BUYING_AGENT BUYING_BROKER
        ESCROW_TITLE_REP HOME_IMPROVEMENT_SPECIALIST HOME_INSPECTOR
        HOME_SECURITY_PROVIDER HOME_WARRANTY_REP INSPECTOR INSURANCE_REP
        LANDLORD LISTING_AGENT LISTING_BROKER LOAN_OFFICER LOAN_PROCESSOR
        MANAGING_BROKER MOVING_STORAGE OTHER PROPERTY_MANAGER SELLER
        SELLER_ATTORNEY TENANT TENANT_AGENT TRANSACTION_COORDINATOR
        UTILITIES_PROVIDER
      ].freeze
      include Virtus.model
      attribute :address
      attribute :cell_phone
      attribute :city
      attribute :company_name
      attribute :country
      attribute :email
      attribute :fax
      attribute :first_name
      attribute :full_name
      attribute :home
      attribute :id, Integer
      attribute :last_name
      attribute :license_number
      attribute :office
      attribute :phone
      attribute :role
      attribute :state
      attribute :state_prov
      attribute :street_name
      attribute :street_number
      attribute :updated, Time
      attribute :zip_code
      attribute :zip_postal_code
    end
  end
end
