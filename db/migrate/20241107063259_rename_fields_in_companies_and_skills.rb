class RenameFieldsInCompaniesAndSkills < ActiveRecord::Migration[7.2]
  def change
    rename_column :companies, :company_name, :name
    rename_column :skills, :skill_name, :skill
  end
end
