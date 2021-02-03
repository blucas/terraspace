module Terraspace::Cloud::Project
  class Url < Base
    def presigned_url
      result = api.create_upload
      if errors?(result)
        error_message(result)
        exit 1 # TODO: consider: raise exception can rescue higher up
      else
        result["url"]
      end
    end
  end
end
