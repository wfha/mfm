module CustomValidators

  # Username
  class Username
    def self.regex
      # By Feng Wan
      # 3 -20 letters, numbers, underscore, or hyphens
      /^[a-z0-9_-]{3,20}$/
    end

    def self.hint
      "should be 3-20 of a-Z, 0-9 or _"
    end
  end

  # Firstname or Lastname
  class Name
    def self.regex
      # By Feng Wan
      # 2 - 50 letters only
      # Following Facebook
      /^[a-zA-Z]{2,50}$/
    end

    def self.hint
      "should be 2-50 of a-Z"
    end
  end

  # Email
  class Email
    def self.regex
      # By Feng Wan
      # /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/

      # By Devise
      /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

      # From Web
      # /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
    end

    def self.hint
      "email format is not correct"
    end
  end

  # Password
  class Password
    def self.regex
      # By Feng Wan
      # 8 - 30, start with letter, follow with letter, number, underscore
      /^[a-zA-Z]\w{7,29}$/

      # From Web
      # /^[a-z0-9_-]{6,18}$/
    end

    def self.hint
      "start with letter, 8-30 long"
    end
  end

  # Credit Card Number
  class CardNumber < ActiveModel::Validator
    def validate(record)
      flag = false
      record.store.payments.each do |p|
        if record.card_number =~ self.send("#{p.name}_regex")
          flag = true
        end
      end
      record.errors[:card_number] << "this store doesn't take this card" unless flag
    end

    def visa_regex
      /^4[0-9]{12}(?:[0-9]{3})?$/
    end

    def mastercard_regex
      /^5[1-5][0-9]{14}$/
    end

    def american_express_regex
      /^3[47][0-9]{13}$/
    end

    def discover_regex
      /^6(?:011|5[0-9]{2})[0-9]{12}$/
    end
  end

  # Credit Card Verification
  class CardVerification
    def self.regex
      /^[0-9]{3}$/
    end

    def self.hint
      "should be 3 numbers"
    end
  end

  # Credit Card Expires At
  class CardExpiresOn
    def self.regex
      /^(?:0[1-9]|1[0-2])\/[0-9]{2}$/
    end

    def self.hint
      "should be MM/YY"
    end
  end

  # Distance between User and Store
  # Problem: Errors cannot be shown correctly on the form attributes!
  class Distance < ActiveModel::Validator
    def validate(record)
      dis = record.store.address.distance_to(record.user.address.address)

      if dis.to_s == 'NaN'
        record.errors[:note] << "please enter a valid address"
      elsif dis > record.store.delivery_radius
        record.errors[:note] << "you are too far away from this restaurant"
      end
    end
  end
end
