# coding: utf-8
require 'json'
require 'open-uri'
require 'csv'

class PersonalQiita
  def get_value_from_raw_json(url)
    json_data = JSON.parse(url)
    titles = Array.new()  

    json_data.each do |data|
      titles << data["title"]
    end
    return titles
  end

  def to_txt(name, titles)
    f = open("src/txt/#{name}.txt", "a") 
    titles.each do |title|
      f.puts title
    end
    f.close
  end

  def user_with_directlink(user)
    url = open("http://qiita.com/api/v2/users/#{user}/stocks").read
    fav_title = get_value_from_raw_json(url)
    to_txt("user", fav_title)
  end

  def articles_with_directlink(page, per)
    for pagenum in 1..page do
      url = open("http://qiita.com/api/v2/items?page=#{pagenum}&per_page=#{per}").read
      latest_title = get_value_from_raw_json(url)
      to_txt("latest", latest_title)
    end
  end
end

if __FILE__ == $0
  obj = PersonalQiita.new()
  obj.user_with_directlink("timakin")
  obj.articles_with_directlink(50, 50)
end