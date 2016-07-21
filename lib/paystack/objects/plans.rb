require "paystack/objects/base.rb"

class PaystackPlans < PaystackBaseObject
  def create(data = {})
    PaystackPlans.create(@paystack, data)
  end

  def get(plan_id)
    PaystackPlans.get(@paystack, plan_id)
  end

  def update(plan_id, data = {})
    PaystackPlans.update(@paystack, plan_id, data)
  end

  def list(page = 1)
    PaystackPlans.list(@paystack, page)
  end

  def self.create(paystackObj, data)
    initPostRequest(paystackObj, API::PLAN_PATH.to_s, data)
  end

  def self.update(paystackObj, plan_id, data)
    initPutRequest(paystackObj, "#{API::PLAN_PATH}/#{plan_id}", data)
  end

  def self.get(paystackObj, plan_id)
    initGetRequest(paystackObj, "#{API::PLAN_PATH}/#{plan_id}")
  end

  def self.list(paystackObj, page = 1)
    initGetRequest(paystackObj, "#{API::PLAN_PATH}?page=#{page}")
  end
end
