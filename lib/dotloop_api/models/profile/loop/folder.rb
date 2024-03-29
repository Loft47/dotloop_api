module DotloopApi
  module Models
    class Profile
      class Loop
        class Folder
          include Virtus.model
          attribute :name
          attribute :id, Integer
          attribute :created, Time
          attribute :updated, Time
          attribute :documents, Array[DotloopApi::Models::Profile::Loop::Folder::Document] # rubocop:disable Style/RedundantArrayConstructor
          attr_accessor :client, :profile_id, :loop_id

          def document_list
            @docuements = DotloopApi::EndPoints::Document.new(
              client:, profile_id:, loop_id:, folder_id: id
            ).all
          end
        end
      end
    end
  end
end
