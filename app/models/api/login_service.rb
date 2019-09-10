module Api
  class LoginService
    def self.call
      @called = true
    end

    def self.called?
      @called
    end
  end
end
