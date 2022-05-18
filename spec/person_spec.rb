require './person'

describe Person do
  context 'Test initialization' do
    it 'gets initialize only with age' do
      age = 14
      person = Person.new(age)
      expect(person.age).to be 14
      expect(person.name).to eq 'Unknown'
      expect(person.id.length).to be > 0
    end

    it 'gets initialize only with data' do
      name = 'Ali'
      age = 14
      id = 'abcd'

      person = Person.new(age, name, id: id)
      expect(person.age).to be 14
      expect(person.name).to eq name
      expect(person.id).to eq 'abcd'
    end
  end
end
