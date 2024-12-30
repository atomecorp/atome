
# Documentation Utilisation d'Atome

## Liste des Propriétés (Particles)
Les particules définissent les caractéristiques d'un objet Atome. Voici la liste complète :

### Catégories et Propriétés Associées

#### Catégorie : Atome
- `creator` : `hash`  
- `aid` : `string`

#### Catégorie : Communication
- `connection` : `hash`  
- `message` : `hash`  
- `int8` : `int`  
- `language` : `string`  
- `controller` : `hash`

#### Catégorie : Effet (Effect)
- `smooth` : `int`  
- `blur` : `int`

#### Catégorie : Événement (Event)
- `touch` : `hash`  
- `play` : `boolean`  
- `pause` : `boolean`  
- `time` : `int`  
- `on` : `boolean`  
- `fullscreen` : `boolean`  
- `mute` : `boolean`  
- `drag` : `boolean`  
- `drop` : `boolean`  
- `over` : `hash`  
- `targets` : `string`  
- `start` : `boolean`  
- `stop` : `boolean`  
- `begin` : `time`  
- `end` : `time`  
- `duration` : `int`  
- `mass` : `int`  
- `damping` : `int`  
- `stiffness` : `int`  
- `velocity` : `int`  
- `ease` : `boolean`  
- `keyboard` : `hash`  
- `resize` : `boolean`  
- `overflow` : `boolean`  
- `animate` : `hash`

#### Catégorie : Géométrie (Geometry)
- `width` : `int`  
- `height` : `int`  
- `size` : `int`

#### Catégorie : Hiérarchie (Hierarchy)
- `attach` : `string`  
- `fasten` : `string`  
- `apply` : `string`  
- `affect` : `string`

#### Catégorie : Non classée (Nil)
- `unfasten` : `string`  
- `detach` : `string`

---

## Liste des Types d'Atome
Voici les types disponibles pour les objets Atome :

- `:editor`
- `:color`
- `:image`
- `:video`
- `:www`
- `:shadow`
- `:border`
- `:raw`
- `:shape`
- `:code`
- `:audio`
- `:element`
- `:animation`
- `:group`
- `:text`
- `:human`
- `:machine`
- `:paint`
- `:vector`
- `:table`
- `:atomized`
- `:map`
- `:vr`
- `:draw`

---

## Exemple d'Utilisation

### Création d'un objet Atome simple
    atome_instance = Atome.new

### Définir une particule
    atome_instance.creator = { name: "Atome Dev" }

### Récupérer une particule
    puts atome_instance.creator

### Lister toutes les particules d’un Atome
    puts atome_instance.instance_variables

### Définir un type d’Atome
    atome_instance.type = :image

---

## Manipulation des Particules

### Animation
    atome_instance.animate = { type: "fade", duration: 2000 }

### Événements
    atome_instance.on = true
    atome_instance.play = true

### Géométrie
    atome_instance.width = 100
    atome_instance.height = 200

---

## Ajout ou Personnalisation
Si des propriétés ou types personnalisés doivent être ajoutés, utilisez le modèle suivant :

    class Atome
      def initialize
        @custom_particules = {}
      end

      def add_particule(name, type, category)
        @custom_particules[name] = { type: type, category: category }
      end

      def list_custom_particules
        @custom_particules
      end
    end

    atome_instance = Atome.new
    atome_instance.add_particule(:custom_prop, :string, :custom_category)
    puts atome_instance.list_custom_particules

---

Ce guide fournit une base pratique pour manipuler les objets Atome et leurs propriétés. Si vous avez des besoins spécifiques, vous pouvez toujours étendre les fonctionnalités en ajoutant des méthodes ou des propriétés personnalisées.
