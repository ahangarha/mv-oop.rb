require './trimmer_decorator'
require './person'

describe TrimmerDecorator do
  context 'test trimmer decorator' do
    it 'trim a long name' do
      name = 'a_very_very_very_long_name'
      age = 1
      person = Person.new(age, name)
      trimmed_person = TrimmerDecorator.new(person)
      expected_name = 'a_very_ver'

      expect(trimmed_person.correct_name).to eq expected_name
    end
  end
end
