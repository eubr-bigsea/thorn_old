class ConfirmAllUsers < ActiveRecord::Migration[6.0]
  def change
    User.all.each(&:confirm)
  end
end
