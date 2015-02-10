# coding: utf-8
require 'json'
require 'open-uri'
require 'csv'

module Qunosy
  class PersonalQiita
    def get_value_from_raw_json(url, column)
      json_data = JSON.parse(url)
      items = Array.new()    

      json_data.each do |data|
        items << data[column]
      end
      return items
    end

    def to_txt(name, items)
      f = open(File.expand_path("../../../src/txt/#{name}.txt", __FILE__), "a") 
      items.each do |item|
        f.puts item
      end
      f.close
    end 

    def user_with_directlink(user)
      url = open("http://qiita.com/api/v2/users/#{user}/stocks").read
      fav_title = get_value_from_raw_json(url, "title")
      to_txt("user", fav_title)
    end 

    def articles_with_directlink(page, per)
      for pagenum in 1..page do
        url = open("http://qiita.com/api/v2/items?page=#{pagenum}&per_page=#{per}").read
        latest_title = get_value_from_raw_json(url, "title")
        latest_url = get_value_from_raw_json(url, "url")
        to_txt("latest", latest_title)
        to_txt("latest_url", latest_url)
      end
    end
  end
end

obj = Qunosy::PersonalQiita.new()
obj.user_with_directlink(ARGV[0])
obj.articles_with_directlink(30, 50)
