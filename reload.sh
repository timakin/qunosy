binary_path=`dirname $0`
cat /dev/null > ${binary_path}/src/txt/user.txt
cat /dev/null > ${binary_path}/src/txt/latest.txt
cat /dev/null > ${binary_path}/src/txt/qiitadicUser.txt
cat /dev/null > ${binary_path}/src/txt/qiitadicLatest.txt
cat /dev/null > ${binary_path}/src/csv/mecabNounUser.csv
cat /dev/null > ${binary_path}/src/csv/mecabNounLatest.csv

ruby ${binary_path}/lib/ruby/get_personal_qiita.rb $1
ruby ${binary_path}/lib/ruby/parseNoun.rb
python3 ${binary_path}/lib/python/make_dict_with_gensim.py
