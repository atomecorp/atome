# mail example

text("send mail")


b=box({x: 333})
b.touch do
  ATOME.message({ type: :mail,
                  content: "hello from atome",
                  from: 'jeezs@jeezs.net',
                  to: 'jeezs@icloud.com',
                  subject: "the human framework",
                  attachment:['/home/atome/www/public/medias/images/freebsd.png', '/home/atome/www/public/medias/images/jeezs.png'] })
end
