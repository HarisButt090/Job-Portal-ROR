module Types
      class FileUpload < GraphQL::Schema::Scalar
        description "A file upload"
  
        def self.coerce_input(value, _context)
          value
        end
  
        def self.coerce_result(value, _context)
          value
        end
      end
end