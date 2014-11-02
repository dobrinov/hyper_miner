require 'open-uri'
require 'nokogiri'
require 'yaml'

class HyperMiner

  def initialize(url, instructions)
    @url = url
    @instructions = YAML.load_file(instructions)
  end

  def mine
    html = open(@url).read

    parse(html)
  end

  private

  def parse(html)
    data = {}

    @instructions.each do |instruction|
      name     = instruction[0]
      selector = instruction[1]['selector']

      data[name] = Nokogiri::HTML(html).css(selector).map(&:text)
    end

    data
  end

end
