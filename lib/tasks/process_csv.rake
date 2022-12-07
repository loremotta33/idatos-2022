namespace :process_csv do
  require 'csv'
  desc "Process PPG dataset"
  task process_ppg: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/All time PPG Leaders.csv', headers: true).each_with_index do |row, index| 
      break unless (points - index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.ppg = points - index
      player.save
    end
  end

  desc "Process APG dataset"
  task process_apg: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/All time APG Leaders.csv', headers: true).each_with_index do |row, index| 
      break unless (points - index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.apg = points - index
      player.save
    end
  end

  desc "Process RPG dataset"
  task process_rpg: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/All time RPG Leaders.csv', headers: true).each_with_index do |row, index| 
      break unless (points - index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.rpg = points - index
      player.save
    end
  end

  desc "Process BPG dataset"
  task process_bpg: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/All time BPG Leaders.csv', headers: true).each_with_index do |row, index| 
      break unless (points - index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.bpg = points - index
      player.save
    end
  end

  desc "Process SPG dataset"
  task process_spg: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/All time SPG Leaders.csv', headers: true).each_with_index do |row, index| 
      break unless (points-index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.spg = points - index
      player.save
    end
  end

  desc "Process WS48 dataset"
  task process_ws48: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/All Time Win Shares Per 48.csv', headers: true).each_with_index do |row, index| 
      break unless (points - index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.ws48 = points - index
      player.save
    end
  end

  desc "Process PER dataset"
  task process_per: :environment do
    points = 75
    CSV.read('Datasets/Basketball Refference/PER rating.csv', headers: true).each_with_index do |row, index| 
      break unless (points - index).positive?
      player = Player.find_or_create_by(player: row['Player'].gsub('*',''))
      player.per = points - index
      player.save
    end
  end

  desc "Process Championships dataset"
  task process_championships: :environment do
    pictures_id = {}
    list_of_players = CSV.read('Datasets/Basketball Refference/Champion Rosters.csv', headers: true).each_with_object({}) do |row, list| 
      list[row['Player']] = list[row['Player']].present? ? list[row['Player']] += 1 : 1
      pictures_id[row['Player']] = row['Player-additional']
    end

    list_of_players.each do |key, value|
      player = Player.find_or_create_by(player: key)
      player.campeonatos = value * 6
      player.basketball_reference_url = "https://www.basketball-reference.com/images/players/#{pictures_id[key]}.jpg"
      player.save
    end
  end

  desc "Process Finals MVP dataset"
  task process_fmvp: :environment do
    list_of_players = CSV.read('Datasets/Basketball Refference/Finals MVP Per year.csv', headers: true)
                      .each_with_object({}) do |row, list| 
                        list[row['Player'].gsub('*','')] = list[row['Player'].gsub('*','')].present? ? list[row['Player'].gsub('*','')] += 1 : 1
                      end

    list_of_players.each do |key, value|
      player = Player.find_or_create_by(player: key)
      player.finals_mvp = value * 6
      player.save
    end
  end

  desc "Process MVP dataset"
  task process_mvp: :environment do
    list_of_players = CSV.read('Datasets/Basketball Refference/MVP Per year.csv', headers: true)
                      .each_with_object({}) do |row, list| 
                        list[row['Player'].gsub('*','')] = list[row['Player'].gsub('*','')].present? ? list[row['Player'].gsub('*','')] += 1 : 1
                      end

    list_of_players.each do |key, value|
      player = Player.find_or_create_by(player: key)
      player.mvp = value * 10
      player.save
    end
  end

  desc "Process All-Star dataset"
  task process_all_star: :environment do

    list_of_players = CSV.read('Datasets/Kaggle/All-Star Selections.csv', headers: true)
                      .each_with_object({}) do |row, list|
                        next unless row['lg'] == 'NBA'
                        list[row['player']] = list[row['player']].present? ? list[row['player']] += 1 : 1
                      end

    list_of_players.each do |key, value|
      player = Player.find_or_create_by(player: key)
      player.all_star = value * 3
      player.save
    end
  end

  desc "Process End of season teams dataset"
  task process_end_of_season: :environment do
    all_nba = {}
    all_defensive = {}
    CSV.read('Datasets/Kaggle/End of Season Teams.csv', headers: true).each do |row|
      next unless ['All-Defense', 'All-NBA'].include?(row['type'])

      points_to_sum = case row['number_tm']
                      when '3rd'
                        1
                      when '2nd'
                        3
                      when '1st'
                        5
                      else 
                        0
                      end

      if row['type'] == 'All-Defense'
        all_defensive[row['player']] = all_defensive[row['player']].present? ? all_defensive[row['player']] += points_to_sum : points_to_sum
      else
        all_nba[row['player']] = all_nba[row['player']].present? ? all_nba[row['player']] += points_to_sum : points_to_sum
      end
    end

    all_nba.each do |key, value|
      player = Player.find_or_create_by(player: key)
      player.all_nba = value * 2
      player.save
    end

    all_defensive.each do |key, value|
      player = Player.find_or_create_by(player: key)
      player.all_defense = value
      player.save
    end
  end

  desc "Calculates the Ranking for each player"
  task calculate_ranking: :environment do
    Player.all.each do |player|
      player.ranking = player.calculate_ranking
      player.save
    end
  end

  desc "Process all datasets"
  task process_all: %i(environment process_csv:process_ppg process_csv:process_apg
                        process_csv:process_rpg process_csv:process_ws48 process_csv:process_per
                        process_csv:process_championships process_csv:process_fmvp process_csv:process_mvp
                        process_csv:process_all_star process_csv:process_end_of_season
                        process_csv:calculate_ranking)


  desc 'Export to CSV'
  task original: :environment do 
    missing_players = []
    original_players = []
    CSV.read('Datasets/Wikipedia/NBA_75th_Anniversary_Team.csv', headers: true).each_with_index do |row, index| 
      if Player.find_by(player: row['Name']).nil?
        missing_players.push(row['Name'])
      end
      original_players.push(row['Name'])
    end

    our_ranking = Player.limit(75).order("ranking desc").map {|player| player.player}

    missing_in_our_ranking = []
    original_players.each do |player|
      missing_in_our_ranking.push(player) unless our_ranking.include?(player)
    end

    missing_in_original_ranking = []
    our_ranking.each do |player|
      missing_in_original_ranking.push(player) unless original_players.include?(player)
    end

    p 'Players present in original ranking that aren\'t present on our ranking'
    p missing_in_our_ranking

    p 'Players present in our ranking that aren\'t present on original ranking '
    p missing_in_original_ranking

    csv = "Position, Player, PosicionPPG, PosicionAPG, PosicionRPG, PosicionWS48, PosicionPER, PuntajeCampeonatos, PuntajeFMVP, PuntajeMVP, PuntajeAllDefense, PuntajeAllNBA, PuntajeAllStar, PuntajeRanking \n"

    Player.all.order("ranking desc").each_with_index do |player, index|
      csv += "#{index + 1}, #{player.csv_string}"
    end
    csv += "\n"

    File.open('result.csv', 'w') { |file| file.write(csv)}
  end
end
