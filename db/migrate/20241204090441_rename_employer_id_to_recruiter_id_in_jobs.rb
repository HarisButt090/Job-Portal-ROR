class RenameEmployerIdToRecruiterIdInJobs < ActiveRecord::Migration[7.2]
  def change
    rename_column :jobs, :employer_id, :recruiter_id
  end
end
