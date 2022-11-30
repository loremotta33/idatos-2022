class Player < ApplicationRecord

  def calculate_ranking
    ranking = ppg + apg + rpg + mvp + finals_mvp + per + ws48 + campeonatos + all_nba + all_defense + all_star
  end


  def image
    basketball_reference_url.present? ? basketball_reference_url : "https://www.basketball-reference.com/images/players/#{image_url}.jpg"
  end

  def image_url
    splitted_name = player.split(' ')
    "#{splitted_name[1][0..4]}#{splitted_name[0][0..1]}01".downcase
  end

  def csv_string
    #  Player, PosicionPPG, PosicionAPG, PosicionRPG, PosicionWS48, PosicionPER, PuntajeCampeonatos, PuntajeFMVP, PuntajeMVP, PuntajeAllDefense, PuntajeAllNBA, PuntajeAllStar, PuntajeRanking
    "#{player}, #{ppg}, #{apg}, #{rpg}, #{ws48}, #{per}, #{campeonatos}, #{finals_mvp}, #{mvp}, #{all_defense}, #{all_nba}, #{all_star}, #{ranking}, #{image}\n"
  end
end
