class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance
  attr_reader :journey_status

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(amount)
    fail "balance exceeds £#{MAXIMUM_LIMIT}" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in
    fail "balance under £#{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT
    @journey_status = true
  end

  def in_journey?
    @journey_status
  end

  def touch_out
    @journey_status = false
    deduct(MINIMUM_AMOUNT)
  end

  private
  attr_reader :deduct
    def deduct(amount)
      @balance -= amount
    end

end
