require 'json'

class Storage
  def initialize(title)
    @title = title
  end

  def save(person_hash)
    serialized_data = serialize(person_hash)

    filename = "#{@title}.json"
    File.write(filename, serialized_data)
  end

  def load
    filename = "#{@title}.json"
    raw_data = File.read(filename)
    JSON.parse(raw_data)
  end

  def serialize(data)
    data_to_proccess = data.map(&:to_hash)
    JSON.pretty_generate(data_to_proccess)
  end
end
