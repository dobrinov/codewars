require_relative 'funnel'

describe Funnel do
  it 'works' do
    funnel = Funnel.new
    funnel.fill 1
    funnel.fill 2
    funnel.fill 3
    funnel.fill 4, 5
    funnel.fill 6, 7, 8, 9
    funnel.drip
    funnel.drip
    funnel.drip
    funnel.drip
    funnel.drip
    funnel.drip
    funnel.drip
    funnel.drip
    funnel.drip
    puts funnel.to_s
  end
end
