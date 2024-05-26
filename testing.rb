class Car
  attr_reader :engine

  def initialize( engine )
    @engine = engine
  end

  def status
    if engine.start?
      "Engine started"
    else
      "Engine stopped"
    end
  end
end

class Engine
  def initialize( state = :stopped )
    @state = state
  end

  def start?
    @state == :started
  end

  def start!
    @state = :started
  end

  def stop!
    @state = :stopped
  end
end

require 'minitest/autorun'

# with stubbing
describe Car do
  it 'correctly reacts to engine start (stubbed)' do
    @engine = Engine.new
    @car = Car.new( @engine )
    @engine.stub :start?, true do
      _( @car.status ).must_equal "Engine started"
    end
    @engine.stub :start?, false do
      _( @car.status ).must_equal "Engine stopped"
    end
  end
end

# with mocking we can test if `start?` was called, with eventually the right 
# arguments
describe Car do
  it 'correctly reacts to engine start (mocked)' do
    @engine = Minitest::Mock.new
    @car = Car.new( @engine )

    @engine.expect :start?, true
    _( @car.status ).must_equal "Engine started"
    @engine.verify

    @engine.expect :start?, false
    _( @car.status ).must_equal "Engine stopped"
    @engine.verify
  end
end
