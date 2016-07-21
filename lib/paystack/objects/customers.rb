require "paystack/objects/base.rb"

class PaystackCustomers < PaystackBaseObject
  def create(data = {})
    PaystackCustomers.create(@paystack, data)
  end

  def get(customer_id)
    PaystackCustomers.get(@paystack, customer_id)
  end

  def update(customer_id, data = {})
    PaystackCustomers.update(@paystack, customer_id, data)
  end

  def list(page = 1)
    PaystackCustomers.list(@paystack, page)
  end

  def self.create(paystackObj, data)
    initPostRequest(paystackObj, API::CUSTOMER_PATH.to_s, data)
  end

  def self.update(paystackObj, customer_id, data)
    initPutRequest(paystackObj, "#{API::CUSTOMER_PATH}/#{customer_id}", data)
  end

  def self.get(paystackObj, customer_id)
    initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}/#{customer_id}")
  end

  def self.list(paystackObj, page = 1)
    initGetRequest(paystackObj, "#{API::CUSTOMER_PATH}?page=#{page}")
  end
end
