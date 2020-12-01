class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance, :journey_status, :entry_station, :journey_history, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
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

  def touch_out(station)
    @exit_station = station
    deduct(MINIMUM_AMOUNT)
    record_journey
    @entry_station = nil
  end

  private
  attr_reader :deduct, :record_journey
    def deduct(amount)
      @balance -= amount
    end

    def record_journey
      journey_history << {entry_station: @entry_station, exit_station: @exit_station}
    end

end
