class MinePlan

  def initialize(html, &block)
    @mined_data = {}
    @html = html

    @instructions = Proc.new { instance_eval(&block) }
  end

  def execute
    @instructions.call
    @mined_data
  end

  private

  def integer(name, options={})
    value = get_value(options[:selector])

    if value
      @mined_data[name] = value.to_i
    else
      @mined_data[name] = nil
    end
  end

  def text(name, options={})
    value = get_value(options[:selector])

    if value
      @mined_data[name] = value
    else
      @mined_data[name] = nil
    end
  end

  def query(selector)
    matching = Nokogiri::HTML(@html).css(selector)
  end

  def get_collection(selector)
    query(selector).map(&:text)
  end

  def get_value(selector)
    matches = query(selector)

    if matches.any?
      matches[0].text
    else
      nil
    end
  end

end
