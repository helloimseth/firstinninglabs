team_names = ["Blue Jays", "Orioles", "Rays", "Red Sox", 
              "Yankees", "Indians", "Royals", "Tigers", 
              "Twins", "White Sox", "Angels", "Astros", 
              "Athletics", "Mariners", "Rangers", "Braves", 
              "Marlins", "Mets", "Nationals", "Phillies", 
              "Brewers", "Cardinals", "Cubs", "Pirates", 
              "Reds", "Dodgers", "Giants", "Padres", 
              "Rockies", "Diamondbacks"]
              
              
team_names.each do |name|
  Team.create!(name: name)
end
