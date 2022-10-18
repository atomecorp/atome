# accumulate example

circle({disposition: :x, color: :red})
box({disposition: :x,  color: {alpha: 0.3, red: 1}})
box({disposition: {x: 33 }, color: :blue})
box({disposition: {y: 33 }, color: :green})
main_bloc=box({center: true})
main_bloc.box({disposition: {y: 33, x: 33 }, color: :green})
main_bloc.box({disposition: {y: 33, x: 33  }, color: :green})
main_bloc.box({disposition: {y: 33 , x: 33 }, color: :green})