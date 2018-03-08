module Templarbit
  module Models
    class User
      attr_accessor :email_address, 
                    :id, 
                    :ip_address, 
                    :name

      def self.new_from_context(context)
        user = self.new
        user.email_address = context.user.email_address
        user.id = context.user.id
        user.name = context.user.name

        return user if context.request.nil?

        serialized_request = Templarbit::Util::RackHttp.serialize_request(context.request)
        user.ip_address = serialized_request[:ip_address]

        return user
      end

      def as_json(options={})
        {
          email: @email_address,
          id: @id,
          ip: @ip_address,
          name: @name
        }
      end

      def to_json(*options)
          as_json(*options).to_json(*options)
      end
    end
  end
end