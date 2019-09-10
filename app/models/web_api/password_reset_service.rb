module WebApi
  class PasswordResetService
    def self.call
      LoginService.call
    end
  end
end
