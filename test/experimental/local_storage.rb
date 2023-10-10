#  frozen_string_literal: true

JS.global[:localStorage].setItem('maCle', 'maValeur')

valeur = JS.global[:localStorage].getItem('maCle')
puts "avant : #{valeur}"
JS.global[:localStorage].removeItem('maCle')

valeur = JS.global[:localStorage].getItem('maCle')
puts "apres : #{valeur}"
