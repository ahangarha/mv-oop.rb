require 'json'

class Storage
  def initialize(title)
    @title = title
  end

  def save(data)
    serialized_data = serialize(data)

    filename = "#{@title}.json"
    File.write(filename, serialized_data)
  end

  def serialize(data)
    data_to_proccess = data.map(&:to_hash)
    JSON.pretty_generate(data_to_proccess)
  end
end
