module DotloopApi
  module Models
    class Profile
      class Loop
        class Folder
          class Document
            include Virtus.model
            attribute :created, Time
            attribute :id, Integer
            attribute :name
            attribute :updated, Time
            attr_accessor :client, :profile_id, :loop_id, :folder_id

            def download
              DotloopApi::EndPoints::Document.new(
                client:, profile_id:, loop_id:, folder_id:
              ).download(id: @id)
            end
          end
        end
      end
    end
  end
end
