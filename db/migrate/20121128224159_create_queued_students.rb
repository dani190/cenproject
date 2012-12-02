class CreateQueuedStudents < ActiveRecord::Migration
  def change
    create_table :queued_students do |t|
      t.string :student_number
      t.string :first_name
      t.string :last_name
      t.integer :position
      t.string :department

      t.timestamps
    end
  end
end
