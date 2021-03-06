class MyAnimeList::CLI

  def call
    make_anime
    list_anime
    menu
    goodbye
  end

  def make_anime
    puts "Loading..."
    MyAnimeList::Scraper.make_anime
  end

  def list_anime
    puts "Best anime:"
    MyAnimeList::Anime.all.each.with_index(1) do |show, i|
      puts "#{i}. #{show.name}; Show Popularity: #{show.members_watched}; Show Length: #{show.time_aired}; Show Length: #{show.show_length}"
      puts "--------------------------------------------------------------------------------------------------------------------------------------------"
    end
  end

  def re_list_anime
    puts "If you would like to see the top x anime, please enter an integer less than #{MyAnimeList::Anime.all.length}. If you would like to see all of the anime again, please enter '#{MyAnimeList::Anime.all.length}'"
    limit = gets.strip.to_i
    MyAnimeList::Anime.all.each.with_index(1) do |show, i|
      if i <= limit
        puts "#{i}. #{show.name}; Show Popularity: #{show.members_watched}; Show Time Aired: #{show.time_aired}; Show Length: #{show.show_length}"
      end
    end
    menu
  end

  def menu
    puts "Enter the number of the anime that you would like to learn more about!"
    puts "You can also enter 'list' to see the list again, or 'exit' to exit."
    input = gets.strip.downcase
    if (input.to_i <=  MyAnimeList::Anime.all.length) && (input.to_i > 0)
      this_anime = MyAnimeList::Anime.find(input.to_i)
      MyAnimeList::Scraper.add_extensive_details_to_anime(this_anime) if this_anime.genres == nil
      puts "Name: #{this_anime.name}"
      puts "Show Popularity: #{this_anime.members_watched}"
      puts "Time Aired: #{this_anime.time_aired}"
      puts "Length: #{this_anime.show_length}"


      puts "Genres: #{this_anime.genres}"
      puts "\n"
      puts "Description: #{this_anime.description}"
      puts "\n"
      open_in_broswer(this_anime.url)
      menu
    elsif input == "list"
      re_list_anime
    elsif input == "exit"
      # exit program
    else
      puts "Command not found"
      menu
    end
  end

  def open_in_broswer(url)
    puts "If you would like to have the url of this page, please enter 'Y'. Else, enter anything else."
    input = gets.strip.upcase
    if input == "Y"
      puts url
    end
  end

  def goodbye
    puts "See you next time!"
  end

end
