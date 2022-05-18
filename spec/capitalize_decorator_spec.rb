require './capitalize_decorator'
require './student'

describe 'capitalize name' do
  context 'test capitalize name' do
    it 'should expect to capitalize name' do
      student = Student.new(nil, 15, 'khalil nasri')
      decorated_student = CapitalizeDecorator.new(student)
      expect(decorated_student.correct_name).to eq('Khalil nasri')
    end
  end
end
