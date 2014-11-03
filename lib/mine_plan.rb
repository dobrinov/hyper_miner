class MinePlan

  attr_reader :mined_data

  def initialize(html, &block)
    @mined_data = {}
    @html = html

    instance_eval(&block)
  end

  def integer(name, options={})
    value = get_value(options[:selector])

    if value

      begin
        @mined_data[name] = Integer(value)
      rescue ArgumentError
        @mined_data[name] = nil
      end

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

  private

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
