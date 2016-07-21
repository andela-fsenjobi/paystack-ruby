require "paystack/utils/utils.rb"

class PaystackCard
  attr_reader :name, :number, :cvc, :expiryMonth, :expiryYear, :addressLine1, :addressLine2, :addressLine3, :addressLine4, :addressCountry, :addressPostalCode, :email, :cardCountry, :cardIssuer

  MAX_DINERS_CARD_LENGTH = 14
  MAX_AMERICAN_EXPRESS_CARD_LENGTH = 15
  MAX_NORMAL_CARD_LENGTH = 16

  PATTERN_VISA = /^4[0-9]{6,}$/
  PATTERN_MASTERCARD = /^5[1-5][0-9]{5,}$/
  PATTERN_AMERICAN_EXPRESS = /^3[47][0-9]{5,}$/
  PATTERN_DINERS_CLUB = /^3(?:0[0-5]|[68][0-9])[0-9]{4,}$/
  PATTERN_DISCOVER = /^6(?:011|5[0-9]{2})[0-9]{3,}$/
  PATTERN_JCB = /^(?:2131|1800|35[0-9]{3})[0-9]{3,}/

  def initialize(args = {})
    @name = Utils.nullifyString(args[:name])
    @number = Utils.nullifyString(args[:number])
    @cvc = Utils.nullifyString(args[:cvc])
    @expiryMonth = Utils.nullifyString(args[:expiryMonth])
    @expiryYear = Utils.nullifyString(args[:expiryYear])
    @cardIssuer = PaystackCard.getCardType(@number)
  end

  def isValidCard
    if !@cvc.nil?
      return isValidNumber && isValidExpiryDate && isValidCVC
    else
      return isValidNumber && isValidExpiryDate
       end
  end

  def self.getCardType(number)
    return "invalid" if number.nil?
    return "visa" if (number =~ PATTERN_VISA) != nil

    return "mastercard" if (number =~ PATTERN_MASTERCARD) != nil

    return "american_express" if (number =~ PATTERN_AMERICAN_EXPRESS) != nil

    return "diners" if number =~ PATTERN_DINERS_CLUB
    return "discover" if number =~ PATTERN_DISCOVER
    return "jcb" if number =~ PATTERN_JCB
    "unknown"
  end

  def isValidNumber
    return false if Utils.isEmpty(@number)
    formatted_number = @number.gsub(/\s+|-/) { |_s| "" }.strip

    if Utils.isEmpty(formatted_number) || !Utils.isWholePositiveNumber(formatted_number) || !Utils.isLuhnValidNumber(formatted_number)

      return false
    end
    if PaystackCard.getCardType(formatted_number).eql?("diners")
      return (formatted_number.length == MAX_DINERS_CARD_LENGTH)
    end

    if PaystackCard.getCardType(formatted_number).eql?("american_express")
      return (formatted_number.length == MAX_AMERICAN_EXPRESS_CARD_LENGTH)
    end

    (formatted_number.length == MAX_NORMAL_CARD_LENGTH)
  end

  def isValidCVC
    return false if @cvc.eql?("")
    cvc = @cvc.strip
    cvc_len = cvc.length

    validLength = ((cvc_len >= 3 && cvc_len <= 4) || (@cardIssuer.eql?("american_express") && cvc_len == 4) || (!@cardIssuer.eql?("american_express") && cvc_len == 3))
  end

  def isValidExpiryDate
    !(@expiryMonth.nil? || @expiryYear.nil?) && Utils.hasCardExpired(@expiryYear, @expiryMonth)
  end
end
