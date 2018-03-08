module Templarbit
  module Models
    class Incident
      attr_accessor :data, 
                    :description, 
                    :sub_type, 
                    :trace, 
                    :type,
                    :status

      def initialize
        @trace = []
      end

      def as_json(options={})
        { 
          data: @data, 
          description: @description, 
          sub_type: @sub_type, 
          trace: @trace, 
          type: @type,
          status: @status
        }
      end

      def to_json(*options)
          as_json(*options).to_json(*options)
      end
    end
  end
end
