class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :student_number
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :pushover_id

      t.timestamps
    end
  end
end
