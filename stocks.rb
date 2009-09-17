require "rubygems"
require "open-uri"
require "csv"
require "yaml"

# Simple stock portfolio using Yahoo stocks

class Time
  def to_s
    self.strftime("%m/%d/%Y %I:%M%p")
  end
end

class StockData
  SOURCE_URL = 'http://download.finance.yahoo.com/d/quotes.csv'
  
  OPTIONS = {
    :symbol => 's',
    :name => 'n', 
    :last_trade_price => 'l1',
    :last_trade_date => 'd1',
    :last_trade_time => 't1',
    :day_low => 'g',
    :day_high => 'h'
  }
  
  def initialize(symbols, options = [:name, :last_trade_price, :last_trade_date, :last_trade_time, :day_high, :day_low])
    @symbols = symbols
    @options = options
    @data = []
  end
  
  def get_data
    symbols_part = @symbols.join('+')
    options_part = @options.map{|s| OPTIONS[s]}.join('')
    url = SOURCE_URL+'?s='+symbols_part+'&f='+options_part 
    CSV.parse open(url).read do |r|
      @data << r
    end
  end
end
