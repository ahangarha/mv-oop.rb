class Service_Provider
  def initialize(service, client)
    @client = client
    @min_acceptable_age = min_acceptable_age
  end

  def can_offer_services?
    client.age > service.min_age_allowed
    # if client.name[0] == 's'
  end

  def serve
    puts 'serve'
  end

  private

  def is_of_age?
    @client.age > @min_acceptable_age
  end
end

# ==================================================

ali = Person.new('ali', 19)
delivery = Service_Provider.new(delivery_service, ali)
delivery.serve if delivery.can_offer_services?

sell_chips = Service_Provider.new(chips, ali, 5)

gift_for_s = Service_Provider.new(gift, ali)
gift_for_s.serve if gift_for_s.can_offer_services?