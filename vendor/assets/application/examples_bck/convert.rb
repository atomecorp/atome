#  frozen_string_literal: true

b = box({ id: :the_html, color: :orange, overflow: :auto, width: :auto, height: :auto, left: 100, right: 100, top: 100, bottom: 100 })
html_desc = <<STR
<!DOCTYPE html>
<html>
    <head>
        <title>Une petite page HTML</title>
        <meta charset="utf-8" />
    </head>
    <body>
        <h1 id='title' style='color: yellowgreen'>Un titre de niveau 1</h1>

        <p>
            Un premier petit paragraphe.
        </p>

        <h2>Un titre de niveau 2</h2>

        <p>
            Un autre paragraphe contenant un lien pour aller
            sur le site <a href="http://koor.fr">KooR.fr</a>.
        </p>
    </body>
</html>
STR

b.hypertext(html_desc)

def markup_analysis(markup) end

def convert(params)
  case
  when params.keys.include?(:atome)

    # Atome.new({type})
    puts params[:atome]
  else
    # ...
  end
end

b.hyperedit(:title) do |tag_desc|
  convert({ atome: tag_desc })
end

# Bien sûr ! Voici une liste des principaux types de balises (tags) HTML. Cependant, notez qu'avec l'évolution du web et les différentes versions de HTML, il peut y avoir de légères variations. Cette liste est basée sur la spécification HTML5 :
#
# 1. **Métadonnées**:
#    - `<!DOCTYPE>`
#    - `<head>`
#    - `<meta>`
#    - `<base>`
#    - `<link>`
#    - `<style>`
#    - `<title>`
#    - `<script>`
#    - `<noscript>`
#
# 2. **Structure du document**:
#    - `<html>`
#    - `<body>`
#    - `<header>`
#    - `<footer>`
#    - `<nav>`
#    - `<article>`
#    - `<section>`
#    - `<aside>`
#    - `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`
#
# 3. **Contenu du texte**:
#    - `<p>`
#    - `<hr>`
#    - `<pre>`
#    - `<blockquote>`
#    - `<ol>`
#    - `<ul>`
#    - `<li>`
#    - `<dl>`
#    - `<dt>`
#    - `<dd>`
#    - `<figure>`
#    - `<figcaption>`
#    - `<div>`
#
# 4. **Contenu en ligne**:
#    - `<a>`
#    - `<em>`
#    - `<strong>`
#    - `<small>`
#    - `<s>`
#    - `<cite>`
#    - `<q>`
#    - `<dfn>`
#    - `<abbr>`
#    - `<data>`
#    - `<time>`
#    - `<code>`
#    - `<var>`
#    - `<samp>`
#    - `<kbd>`
#    - `<sub>`
#    - `<sup>`
#    - `<i>`
#    - `<b>`
#    - `<u>`
#    - `<mark>`
#    - `<ruby>`
#    - `<rt>`
#    - `<rp>`
#    - `<bdi>`
#    - `<bdo>`
#    - `<span>`
#    - `<br>`
#    - `<wbr>`
#
# 5. **Contenu intégré**:
#    - `<img>`
#    - `<iframe>`
#    - `<embed>`
#    - `<object>`
#    - `<param>`
#    - `<video>`
#    - `<audio>`
#    - `<source>`
#    - `<track>`
#    - `<canvas>`
#    - `<map>`
#    - `<area>`
#    - `<svg>`
#    - `<math>`
#
# 6. **Données du formulaire**:
#    - `<form>`
#    - `<input>`
#    - `<textarea>`
#    - `<button>`
#    - `<select>`
#    - `<optgroup>`
#    - `<option>`
#    - `<label>`
#    - `<fieldset>`
#    - `<legend>`
#    - `<datalist>`
#    - `<output>`
#    - `<progress>`
#    - `<meter>`
#
# 7. **Éléments interactifs**:
#    - `<details>`
#    - `<summary>`
#    - `<command>`
#    - `<menu>`
#
# 8. **Éléments d'écriture**:
#    - `<script>`
#    - `<noscript>`
#    - `<template>`
#    - `<canvas>`
#
# 9. **D'autres éléments** (comme les éléments dépréciés ou obsolètes de versions antérieures de HTML) peuvent également être trouvés dans le wild web, mais leur utilisation n'est pas recommandée dans les nouveaux projets.
#
# Cette liste n'est pas exhaustive et certaines balises pourraient être ajoutées ou modifiées avec de futures versions de HTML. Toujours se référer à la documentation officielle ou à des ressources fiables pour une liste complète à jour.