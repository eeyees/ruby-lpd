require 'awesome_print'

str="abcd efg aaa";

arr = str.split(/ /).unshift(str[0])

ap arr

ap Time.now.to_i.to_s