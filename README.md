# Qunosy
Personal Gunosy for Qiita
With machine learning, corpus clustering, 
recommend you the latest code that match your interest.
Qunosy adopt random forest as clustering method.

# requirements
- Python3
  - scikit-learn
  - gensim
- Ruby
  - natto
- mecab
- Go (*and setting for GOPATH)

# How to use

## Clone
```
$ git clone git@github.com:timakin/qunosy.git

#########################################################
### change directory to below $GOPATH/*               ###
### I recommend to clone qunosy to $GOPATH/src/qunosy ###
### If you don't installing tool will fail.           ###
#########################################################
```

## Install as cli tool
```
$ go install
```

## Do it!
```
### Load latest recommendation. (*You can do it only 1 time a day 'cause of API limitation.)
$ qunosy reload userQiitaId
### Display your recommendation without reloading.
$ qunosy
```
