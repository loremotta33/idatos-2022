class Player < ApplicationRecord

  def calculate_ranking
    ranking = ppg + apg + rpg + mvp + finals_mvp + per + ws48 + campeonatos + all_nba + all_defense + all_star
  end

  def csv_string
    "#{player}, #{ppg}, #{apg}, #{rpg}, #{ws48}, #{per}, #{campeonatos}, #{finals_mvp}, #{mvp}, #{all_defense}, #{all_nba}, #{all_star}, #{ranking}\n"
  end
end
