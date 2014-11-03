require 'open-uri'
require 'nokogiri'

require 'mine_plan.rb'

class HyperMiner

  def initialize(resource_url)
    @resource_url = resource_url
  end

  def mine(&block)
    raise "Provide mine instructions." unless block_given?

    html = get_resource_html
    mine_plan = MinePlan.new(html, &block)

    mine_plan.mined_data
  end

  private

  def get_resource_html
    open(@resource_url).read
  end

end
