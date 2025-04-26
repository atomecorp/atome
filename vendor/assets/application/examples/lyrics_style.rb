# frozen_string_literal: true

# Module de centralisation des styles pour l'application Lyricist
module LyricistStyles
  # Méthode pour récupérer les styles globaux
  def global_styles
    {
      line_width: 1600,
      base_colors: {
        primary: { red: 0.2, green: 0.2, blue: 0.4 },
        secondary: { red: 0.3, green: 0.3, blue: 0.3 },
        accent: :orange,
        text_normal: :white,
        text_muted: :gray,
        text_highlight: :yellow,
        success: :green,
        warning: :orange,
        danger: :red,
        info: :lightblue,
        dark: { red: 0.15, green: 0.15, blue: 0.2 }
      },
      button_sizes: {
        small: { width: 25, height: 25 },
        default: { width: 33, height: 19 },
        medium: { width: 60, height: 25 },
        large: { width: 120, height: 30 }
      },
      text_sizes: {
        xs: 9,
        sm: 11,
        base: 14,
        lg: 16,
        xl: 20,
        xxl: 33
      },
      spacing: {
        xs: 3,
        sm: 6,
        md: 10,
        lg: 20,
        xl: 30
      },
      radius: {
        none: 0,
        sm: 5,
        md: 6,
        lg: 9,
        xl: 10
      }
    }
  end

  # Styles pour les boutons
  def button_style(type = :default, options = {})
    styles = global_styles

    # Types de boutons prédéfinis
    button_types = {
      default: {
        color: styles[:base_colors][:accent],
        size: styles[:button_sizes][:default],
        text_color: styles[:base_colors][:text_normal],
        text_size: styles[:text_sizes][:xs],
        radius: styles[:radius][:md]
      },
      primary: {
        color: styles[:base_colors][:primary],
        size: styles[:button_sizes][:default],
        text_color: styles[:base_colors][:text_normal],
        text_size: styles[:text_sizes][:xs],
        radius: styles[:radius][:md]
      },
      success: {
        color: styles[:base_colors][:success],
        size: styles[:button_sizes][:default],
        text_color: styles[:base_colors][:text_normal],
        text_size: styles[:text_sizes][:xs],
        radius: styles[:radius][:md]
      },
      danger: {
        color: styles[:base_colors][:danger],
        size: styles[:button_sizes][:default],
        text_color: styles[:base_colors][:text_normal],
        text_size: styles[:text_sizes][:xs],
        radius: styles[:radius][:md]
      },
      warning: {
        color: styles[:base_colors][:warning],
        size: styles[:button_sizes][:default],
        text_color: styles[:base_colors][:text_normal],
        text_size: styles[:text_sizes][:xs],
        radius: styles[:radius][:md]
      },
      info: {
        color: styles[:base_colors][:info],
        size: styles[:button_sizes][:default],
        text_color: styles[:base_colors][:text_normal],
        text_size: styles[:text_sizes][:xs],
        radius: styles[:radius][:md]
      }
    }

    # Récupérer le style de base selon le type
    base_style = button_types[type] || button_types[:default]

    # Fusionner avec les options spécifiques
    base_style.merge(options)
  end

  # Méthode pour créer un bouton avec style unifié
  def create_button(parent, id, text, type = :default, position = {}, options = {})
    style = button_style(type, options)

    # Créer le bouton
    button = parent.box({
                          id: id,
                          width: style[:size][:width],
                          height: style[:size][:height],
                          color: style[:color],
                          smooth: style[:radius],
                          left: position[:left] || 0,
                          top: position[:top] || 0,
                          right: position[:right],
                          position: position[:position]
                        })

    # Ajouter le texte au bouton
    button.text({
                  data: text,
                  component: { size: style[:text_size] },
                  top: position[:text_top] || -12,
                  left: position[:text_left] || 3,
                  position: :absolute,
                  color: style[:text_color]
                })

    button
  end

  # Styles pour les conteneurs
  def container_style(type = :default, options = {})
    styles = global_styles

    container_types = {
      default: {
        color: styles[:base_colors][:secondary],
        radius: styles[:radius][:md],
        padding: styles[:spacing][:md]
      },
      primary: {
        color: styles[:base_colors][:primary],
        radius: styles[:radius][:md],
        padding: styles[:spacing][:md]
      },
      dark: {
        color: styles[:base_colors][:dark],
        radius: styles[:radius][:lg],
        padding: styles[:spacing][:md]
      }
    }

    base_style = container_types[type] || container_types[:default]
    base_style.merge(options)
  end

  # Méthode pour créer un conteneur avec style unifié
  def create_container(parent, id, type = :default, position = {}, options = {})
    style = container_style(type, options)

    parent.box({
                 id: id,
                 width: position[:width] || 400,
                 height: position[:height] || 300,
                 color: style[:color],
                 smooth: style[:radius],
                 left: position[:left] || 0,
                 top: position[:top] || 0,
                 right: position[:right],
                 overflow: options[:overflow],
                 shadow: options[:shadow],
                 position: position[:position],
                 drag: options[:drag],
                 resize: options[:resize]
               })
  end

  # Styles pour les textes
  def text_style(type = :default, options = {})
    styles = global_styles

    text_types = {
      default: {
        color: styles[:base_colors][:text_normal],
        size: styles[:text_sizes][:base]
      },
      title: {
        color: styles[:base_colors][:text_normal],
        size: styles[:text_sizes][:lg]
      },
      subtitle: {
        color: styles[:base_colors][:text_normal],
        size: styles[:text_sizes][:base]
      },
      highlight: {
        color: styles[:base_colors][:text_highlight],
        size: styles[:text_sizes][:base]
      },
      muted: {
        color: styles[:base_colors][:text_muted],
        size: styles[:text_sizes][:base]
      },
      large: {
        color: styles[:base_colors][:text_normal],
        size: styles[:text_sizes][:xxl]
      }
    }

    base_style = text_types[type] || text_types[:default]
    base_style.merge(options)
  end

  # Méthode pour créer un texte avec style unifié
  def create_text(parent, id, content, type = :default, position = {}, options = {})
    style = text_style(type, options)

    parent.text({
                  id: id,
                  data: content,
                  component: { size: style[:size] },
                  color: style[:color],
                  left: position[:left] || 0,
                  top: position[:top] || 0,
                  position: position[:position] || :absolute,
                  width: position[:width],
                  edit: options[:edit]
                })
  end

  # Positions standardisées pour les éléments d'interface
  def ui_positions
    {
      control_buttons: {
        start: { left: 0, top: 0 },
        erase: { left: 39, top: 0 },
        stop: { left: 125, top: 0 },
        pause: { left: 160, top: 0 }
      },
      record_button: { left: 39, top: 39 },
      edit_lyrics_button: { left: 320, top: 39 },
      lyrics_support: { left: 35, top: 120, width: 180, height: 180 },
      timeline_slider: { left: 99, top: 350, width: 333, height: 25 },
      navigation_buttons: {
        prev: { left: 220, top: 0, width: 39, height: 20 },
        next: { left: 270, top: 0, width: 39, height: 20 }
      },
      song_support: {
        top: 3,
        right: 9,
        width: 399,
        height: 600
      },
      lyrics_editor: {
        default: { left: 400, top: 120, width: 500, height: 400 },
        line_container: { width: 470, height: 50, left: 10 },
        line_elements: {
          timecode: { left: 10, top: 10, width: 70 },
          text: { left: 90, top: 10, width: 300 },
          update: { left: 400, top: 10 },
          delete: { left: 435, top: 10 }
        }
      }
    }
  end

  # Méthode pour obtenir une position prédéfinie
  def get_position(element_path)
    path_parts = element_path.to_s.split('.')
    current = ui_positions

    path_parts.each do |part|
      current = current[part.to_sym] if current.is_a?(Hash) && current[part.to_sym]
    end

    current
  end
end

# Ajoutons la classe Lyricist ici pour s'assurer que le module est inclus
class Lyricist < Atome
  include LyricistStyles
end