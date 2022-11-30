class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :player, null: false
      t.integer :ppg, null: false, default: 0
      t.integer :apg, null: false, default: 0
      t.integer :rpg, null: false, default: 0
      t.integer :spg, null: false, default: 0
      t.integer :bpg, null: false, default: 0
      t.integer :mvp, null: false, default: 0
      t.integer :finals_mvp, null: false, default: 0
      t.integer :per, null: false, default: 0
      t.integer :ws48, null: false, default: 0
      t.integer :campeonatos, null: false, default: 0
      t.integer :all_nba, null: false, default: 0
      t.integer :all_defense, null: false, default: 0
      t.integer :all_star, null: false, default: 0
      t.integer :ranking, null: false, default: 0
      t.string :basketball_reference_url

      t.timestamps
    end
  end
end
