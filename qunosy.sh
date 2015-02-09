cat /dev/null > src/txt/user.txt
cat /dev/null > src/txt/latest.txt
cat /dev/null > src/txt/qiitadicUser.txt
cat /dev/null > src/txt/qiitadicLatest.txt
cat /dev/null > src/csv/mecabNounUser.csv
cat /dev/null > src/csv/mecabNounLatest.csv

ruby lib/ruby/get_personal_qiita.rb $1
ruby lib/ruby/parseNoun.rb
python3 lib/python/make_dict_with_gensim.py
