require "rest-client"
require "paystack/error.rb"
require "paystack/modules/api.rb"
require "paystack/utils/utils.rb"
require "paystack/objects/card.rb"
require "paystack/objects/customers.rb"
require "paystack/objects/plans.rb"
require "paystack/objects/transactions.rb"

class Paystack
  attr_reader :public_key, :private_key

  def initialize(paystack_public_key = nil, paystack_private_key = nil)
    @public_key = if paystack_public_key.nil?
                    ENV["PAYSTACK_PUBLIC_KEY"]

                  else
                    paystack_public_key
                  end

    @private_key = if paystack_private_key.nil?
                     ENV["PAYSTACK_PRIVATE_KEY"]
                   else
                     paystack_private_key
                   end

    if @public_key.nil?
      raise PaystackBadKeyError, "No public key supplied and couldn't find any in environment variables. Make sure to set public key as an environment variable PAYSTACK_PUBLIC_KEY"
    end
    unless @public_key[0..2] == "pk_"
      raise PaystackBadKeyError, "Invalid public key #{@public_key}"
    end

    if @private_key.nil?
      raise PaystackBadKeyError, "No private key supplied and couldn't find any in environment variables. Make sure to set private key as an environment variable PAYSTACK_PRIVATE_KEY"
    end
    unless @private_key[0..2] == "sk_"
      raise PaystackBadKeyError, "Invalid private key #{@private_key}"
    end
  end

  def setPublicKey(public_key)
    @public_key = public_key
  end

  def setPrivateKey(public_key)
    @public_key = public_key
  end
end
