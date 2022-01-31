# mail example

text("send mail")


b=box({x: 333})
b.touch do
  ATOME.message({type: :mail,from: 'contact@atome.one', to: 'jeezs@icloud.com', subject: "it's about...", content: 'hello jeezs! how are you', attachment:['/home/atome/www/public/medias/images/freebsd.png', '/home/atome/www/public/medias/images/jeezs.png']})
end
