module Terraspace::Cloud::Api::Concern
  module Record
    def load_record(result)
      record = {}
      data = result['data']
      record['id'] = data['id']
      record.merge!(data['attributes'])
      record
    end
  end
end
