class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.string :result

      t.timestamps
      t.references :invoice, foreign_key: true
    end
  end
end
