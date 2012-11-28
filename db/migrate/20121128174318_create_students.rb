class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :student_number
      t.string :first_name
      t.string :last_name
      t.string :pushover_user
      t.string :pushover_token

      t.timestamps
    end
  end
end
