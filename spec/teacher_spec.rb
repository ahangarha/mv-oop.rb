require './teacher'

describe Teacher do
  context 'Test initialization' do
    it 'gets initialize only with specialization and age' do
      specialization = 'Math'
      age = 36
      teacher = Teacher.new(specialization, age)

      expect(teacher.age).to be age
      expect(teacher.name).to eq 'Unknown'
      expect(teacher.id.length).to be > 0
    end

    it 'gets initialize only with data' do
      specialization = 'Math'
      name = 'Ali'
      age = 36
      id = 'abcd'

      teacher = Teacher.new(specialization, age, name, id: id)
      expect(teacher.age).to be age
      expect(teacher.name).to eq name
      expect(teacher.id).to eq 'abcd'
    end
  end
end
