#  frozen_string_literal: true

b = box({ id: :the_html, color: :orange, overflow: :auto, width: :auto, height: :auto, left: 100, right: 100, top: 100, bottom: 100 })
# html_desc=<<STR
# <!DOCTYPE html>
# <html>
#     <head>
#         <title>Une petite page HTML</title>
#         <meta charset="utf-8" />
#     </head>
#     <body>
#         <h1 id='title' style='color: yellowgreen'>Un titre de niveau 1</h1>
#
#         <p>
#             Un premier petit paragraphe.
#         </p>
#
#         <h2>Un titre de niveau 2</h2>
#
#         <p>
#             Un autre paragraphe contenant un lien pour aller
#             sur le site <a href="http://koor.fr">KooR.fr</a>.
#         </p>
#     </body>
# </html>
# STR
html_desc = <<STR
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Com 1 Image</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
        header { display: flex; justify-content: space-between; align-items: center; padding: 20px; }
        nav { display: none; } 
        .section { padding: 50px 20px; text-align: center;z-index: 3  }
        .contact-info { text-align: left; }
        @media (min-width: 768px) {
            nav { display: block; }
        }
    </style>
  <style>
        .ok-info { text-align: left; }
        @media (min-width: 768px) {
            nav { display: block; }
        }
    </style>
</head>
<body>

<header>
    <button>☰</button> <!-- Icône de menu pour mobile -->
    <h1>Com 1 Image</h1>
    <nav>
        <a href="#accueil">Accueil</a>
    </nav>
</header>

<section id='div_id' class="section my_class" style='left: 333px;color: yellow'>
    <h2>PRODUCTIONS AUDIOVISUELLES</h2>
    <!-- Contenu de la section -->
</section>

<section class="section">
    <h2>COLLABORATIF</h2>
    <p>Texte sur le collaboratif...</p>
</section>

<section class="section">
    <h2>CORPORATE</h2>
    <div class="communication">
        <!-- Images et textes liés à la communication -->
    </div>
    <div class="publicite">
        <!-- Images et textes liés à la publicité -->
    </div>
    <!-- ... Autres contenus de la section Corporate -->
</section>

<section class="section">
    <h2>ART</h2>
    <p>Texte sur l'art...</p>
</section>

<section class="section contact-info">
    <h2>CONTACT</h2>
    <p>email@example.com</p>
    <address>
        74 bis avenue des Thèmes<br>
        63400 - Chamalières
    </address>
</section>

</body>
</html>

STR
b.hypertext(html_desc)

# b.hyperedit(id)  do |html_object|
# id convert to atome
# get tage type  convert to markup
# get tag content convert to data
# get style and class convert to particle
# end
b.hyperedit(:div_id) do |tag_desc|
  puts  tag_desc.class
end

  wait 2 do
    div_result = HTML.locate(id: 'div_id') # find by ID

    atomized_el= atomizer({ target: div_result, id: :my_second_html_obj })
    atomized_el.rotate(55)
    atomized_el.color(:purple)
    atomized_el.position(:absolute)
    atomized_el.left(255)
    atomized_el.top(255)
  end


wait 3 do
  # or handle the objet in pure ruby js style
  div_result = HTML.locate(id: 'div_id') # find by ID
  div_result[:style][:left]= "66px"
  puts "the div is : #{div_result[:style][:left]}"


end

# TODO : create an html to atome converter


def api_infos
  {
  "example": "Purpose of the example",
  "methods_found": [
    "0",
    "class",
    "color",
    "com",
    "fr",
    "hyperedit",
    "hypertext",
    "left",
    "locate",
    "position",
    "rotate",
    "top"
  ],
  "0": {
    "aim": "The `0` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `0`."
  },
  "class": {
    "aim": "The `class` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `class`."
  },
  "color": {
    "aim": "Sets or modifies the color of the object.",
    "usage": "For example, `color(:red)` changes the object's color to red."
  },
  "com": {
    "aim": "The `com` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `com`."
  },
  "fr": {
    "aim": "The `fr` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `fr`."
  },
  "hyperedit": {
    "aim": "The `hyperedit` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `hyperedit`."
  },
  "hypertext": {
    "aim": "The `hypertext` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `hypertext`."
  },
  "left": {
    "aim": "Controls the horizontal position of the object within its container.",
    "usage": "For example, `left(100)` moves the object 100 pixels from the left edge."
  },
  "locate": {
    "aim": "The `locate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `locate`."
  },
  "position": {
    "aim": "The `position` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `position`."
  },
  "rotate": {
    "aim": "The `rotate` method's purpose is determined by its specific functionality.",
    "usage": "Refer to Atome documentation for detailed usage of `rotate`."
  },
  "top": {
    "aim": "Defines the vertical position of the object in its container.",
    "usage": "For instance, `top(50)` sets the object 50 pixels from the top edge."
  }
}
end
