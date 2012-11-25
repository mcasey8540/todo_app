class AddSmsFrequencyToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :sms_frequency, :string
  end
end
