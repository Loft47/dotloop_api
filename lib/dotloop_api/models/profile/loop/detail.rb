module DotloopApi
  module Models
    class Profile
      class Loop
        class Detail
          include Virtus.model
          class ContractDates
            include Virtus.model
            attribute :contract_agreement_date
            attribute :closing_date
          end

          class ContractInfo
            include Virtus.model
            attribute :transaction_number
            attribute :start_date
            attribute :end_date
          end

          class Financials
            include Virtus.model
            attribute :earnest_money_amount
            attribute :earnest_money_held_by
            attribute :purchase_sale_price
            attribute :rent
            attribute :rent_commission_amount
            attribute :sale_commission_rate
            attribute :sale_commission_split_dollar_buy_side
            attribute :sale_commission_split_dollar_sell_side
            attribute :sale_commission_split_percent_buy_side
            attribute :sale_commission_split_percent_sell_side
            attribute :sale_commission_total
          end

          class GeographicDescription
            include Virtus.model
            attribute :addition
            attribute :block
            attribute :deed_book
            attribute :deed_page
            attribute :lot
            attribute :map_grid
            attribute :mls_area
            attribute :legal_description
            attribute :section
            attribute :subdivision
          end

          class ListingInformation
            include Virtus.model
            attribute :current_price
            attribute :description_of_other_liens
            attribute :expiration_date
            attribute :first_mortgage_balance
            attribute :homeowner_association
            attribute :homeowner_association_dues
            attribute :listing_date
            attribute :original_price
            attribute :other_liens
            attribute :property_excludes
            attribute :property_includes
            attribute :remarks
            attribute :second_mortgage_balance
            attribute :total_encumbrances
          end

          class Participant < DotloopApi::Models::Contact; end

          class OfferDates
            include Virtus.model
            attribute :offer_date
            attribute :inspection_date
            attribute :occupancy_date
            attribute :offer_expiration_date
          end

          class Property
            include Virtus.model
            attribute :bathrooms
            attribute :bedrooms
            attribute :lot_size
            attribute :school_d
            attribute :square_footage
            attribute :type
            attribute :year_built
          end

          class PropertyAddress
            include Virtus.model
            attribute :city
            attribute :country
            attribute :county
            attribute :mls_number
            attribute :parcel_tax_id
            attribute :postal_code
            attribute :property_address_country
            attribute :state_or_province
            attribute :street_name
            attribute :street_number
            attribute :unit_number
          end

          class Referral
            include Virtus.model
            attribute :referral_source
            attribute :referral_percentage
          end

          attribute :contract_dates, DotloopApi::Models::Profile::Loop::Detail::ContractDates
          attribute :contract_info, DotloopApi::Models::Profile::Loop::Detail::ContractInfo
          attribute :financials, DotloopApi::Models::Profile::Loop::Detail::Financials
          attribute :geographic_description, DotloopApi::Models::Profile::Loop::Detail::GeographicDescription
          attribute :listing_information, DotloopApi::Models::Profile::Loop::Detail::ListingInformation
          attribute :offer_dates, DotloopApi::Models::Profile::Loop::Detail::OfferDates
          attribute :property_address, DotloopApi::Models::Profile::Loop::Detail::PropertyAddress
          attribute :property, DotloopApi::Models::Profile::Loop::Detail::Property
          attribute :referral, DotloopApi::Models::Profile::Loop::Detail::Referral
          attr_accessor :client
          attr_accessor :profile_id
          attr_accessor :loop_id

          def save
            DotloopApi::EndPoints::Detail.new(
              client: client, profile_id: profile_id, loop_id: loop_id
            ).save(self)
          end
        end
      end
    end
  end
end
