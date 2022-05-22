require './student'

describe Student do
  context 'basic initialisation of Student class' do
    name = 'dan'
    age = 14
    classroom = nil
    student = Student.new(classroom, age, name)

    it 'should be equal to student name' do
      expect(student.name).to eq 'dan'
    end

    it 'should be equal to student age' do
      expect(student.age).to be 14
    end
  end

  context 'test :to_hash method' do
    it 'generate correct hash of the object' do
      classroom = nil
      age = 36
      name = 'Reza'
      id = 'blah'
      parent_permission = false

      student = Student.new(classroom, age, name, parent_permission: parent_permission, id: id)

      expected_hash = {
        class: 'Student',
        id: id,
        name: name,
        age: age,
        parent_permission: parent_permission,
        classroom: classroom
      }

      expect(student.to_hash).to eq expected_hash
    end
  end
end
