require './student'

describe 'basic initialisation of Student class' do
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
