# coding: utf-8
require 'json'
require 'open-uri'
require 'csv'

module Qunosy
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
      f = open(File.expand_path("../../src/txt/#{name}.txt", __FILE__), "a") 
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
end

obj = Qunosy::PersonalQiita.new()
obj.user_with_directlink(ARGV[0])
obj.articles_with_directlink(30, 50)
