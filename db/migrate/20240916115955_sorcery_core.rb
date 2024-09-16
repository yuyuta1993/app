class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :crypted_password unless column_exists?(:users, :crypted_password)
      t.string :salt unless column_exists?(:users, :salt)
    end
  end
end
