class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance, :journey_status, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "balance exceeds £#{MAXIMUM_LIMIT}" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "balance under £#{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT
    @entry_station = station
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_out
    @entry_station = nil
    deduct(MINIMUM_AMOUNT)
  end

  private
  attr_reader :deduct
    def deduct(amount)
      @balance -= amount
    end

end
