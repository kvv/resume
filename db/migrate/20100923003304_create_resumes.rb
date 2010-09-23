class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.string :full_name
      t.date :birthday
      t.string :sex
      t.string :family
      t.text :education
      t.text :additional_education
      t.text :personal_qualities
      t.text :skills
      t.string :job
      t.text :experience
      t.text :additional_information
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :resumes
  end
end