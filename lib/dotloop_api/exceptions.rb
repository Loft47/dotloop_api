module DotloopApi
  class BadRequest < StandardError; end
  class Forbidden < StandardError; end
  class MissingRefreshToken < StandardError; end
  class MissingRevokeToken < StandardError; end
  class NotFound < StandardError; end
  class NotImplemented < StandardError; end
  class TooManyRequests < StandardError; end
  class Unauthorized < StandardError; end
  class UnmatchState < StandardError; end
  class UnprocessableEntity < StandardError; end

  class CodeMap
    def self.call(code)
      return if code == 200
      {
        400 => DotloopApi::BadRequest,
        401 => DotloopApi::Unauthorized,
        403 => DotloopApi::Forbidden,
        404 => DotloopApi::NotFound,
        422 => DotloopApi::UnprocessableEntity,
        429 => DotloopApi::TooManyRequests
      }.fetch(code, StandardError)
    end
  end
end
