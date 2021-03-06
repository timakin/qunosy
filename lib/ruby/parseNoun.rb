# coding: utf-8
require 'natto'
require 'csv'

module Qunosy
  class ParseNoun
    def initialize
      @nm = Natto::MeCab.new
    end 

    def parse_file(file_path)
      file = File.open(file_path,"r")
      texts = Array.new
      for row in file
        texts << row
      end
      return texts
    end 

    def parse_noun(texts)
      noun = Array.new
      for text in texts
        unit_noun = Array.new
        @nm.parse(text) do |n|
          if n.feature.include?("名詞")
            unit_noun << n.surface
          end
        end
        noun << unit_noun
      end
      return noun
    end 

    def to_csv(name, noun)
      CSV.open(File.expand_path("../../../src/csv/#{name}.csv", __FILE__), 'a') do |csv| 
        for n in noun
          csv << n
        end
      end
    end
  end
end

if __FILE__ == $0
  # parsing and writing noun of article titles in every cases.
  mecab = Qunosy::ParseNoun.new
  # texts = mecab.parse_file("src/txt/article.txt")
  # noun = mecab.parse_noun(texts)
  # mecab.to_csv("mecabNoun", noun)

  texts = mecab.parse_file(File.expand_path("../../../src/txt/user.txt", __FILE__))
  noun = mecab.parse_noun(texts)
  mecab.to_csv("mecabNounUser", noun)

  texts = mecab.parse_file(File.expand_path("../../../src/txt/latest.txt", __FILE__))
  noun = mecab.parse_noun(texts)
  mecab.to_csv("mecabNounLatest", noun)
end