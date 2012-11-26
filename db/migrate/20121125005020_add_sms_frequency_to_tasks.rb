class AddSmsFrequencyToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :sms_reminder, :string
  end
end
