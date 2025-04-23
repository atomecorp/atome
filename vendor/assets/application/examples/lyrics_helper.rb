

class Lyricist < Atome
  def build_lyrics_editor_button
    # Création du bouton d'édition des paroles
    edit_lyrics = grab(:view).box({
                                    id: :edit_lyrics_button,
                                    width: 60,
                                    height: 25,
                                    left: 320,
                                    top: 39,
                                    color: :lightblue,
                                    smooth: 6
                                  })
    edit_lyrics.text({
                       data: "Edit",
                       component: { size: 11 },
                       position: :absolute,
                       left: 10,
                       top: 3,
                       color: :darkblue
                     })

    # Variable pour suivre si l'éditeur est ouvert ou fermé
    @editor_open = false

    edit_lyrics.touch(true) do
      if @editor_open
        # Fermer l'éditeur s'il est déjà ouvert
        grab(:lyrics_editor_container).delete({ recursive: true }) if grab(:lyrics_editor_container)
        @editor_open = false
      else
        # Ouvrir l'éditeur
        @editor_open = true
        show_lyrics_editor(400, 120)
      end
    end
  end

  def show_lyrics_editor(left_f, top_f)
    # Conteneur principal pour l'éditeur
    editor_container = grab(:view).box({
                                         id: :lyrics_editor_container,
                                         width: 500,
                                         height: 400,
                                         top: top_f,
                                         left: left_f,
                                         position: :absolute,
                                         color: { red: 0.15, green: 0.15, blue: 0.2 },
                                         smooth: 10,
                                         shadow: { blur: 15, alpha: 0.7 },
                                         overflow: :auto,
                                         drag: true,
                                         resize: true,

                                       })

    # Titre de l'éditeur
    editor_container.text({
                            data: "Lyrics editor",
                            component: { size: 16 },
                            position: :absolute,
                            color: :white,
                            left: 33,
                            top: 10
                          })

    # Bouton pour fermer l'éditeur
    close_button = editor_container.box({
                                          width: 25,
                                          height: 25,
                                          right: 10,
                                          top: 10,
                                          color: :red,
                                          smooth: 5
                                        })
    close_button.text({
                        data: "X",
                        component: { size: 12 },
                        position: :absolute,
                        color: :white,
                        left: 8,
                        top: 3
                      })
    close_button.touch(true) do
      editor_container.delete({ recursive: true })
      @editor_open = false
    end

    # Récupération et tri des paroles
    lyrics = grab(:lyric_viewer)
    sorted_lyrics = lyrics.content.sort.to_h

    # Affichage des paroles avec options d'édition
    sorted_lyrics.each_with_index do |(timecode, text), index|
      y_position = 50 + (index * 60)

      # Conteneur pour chaque ligne
      line_container = editor_container.box({
                                              id: "line_container_#{index}".to_sym,
                                              width: 470,
                                              height: 50,
                                              left: 10,
                                              top: y_position,
                                              color: { red: 0.25, green: 0.25, blue: 0.3 },
                                              smooth: 6
                                            })

      # Champ pour le timecode
      timecode_field = line_container.text({
                                             id: "timecode_#{index}".to_sym,
                                             data: timecode.to_s,
                                             component: { size: 14 },
                                             edit: true,
                                             width: 70,
                                             position: :absolute,
                                             left: 10,
                                             top: 10,
                                             color: :yellow
                                           })


      # Champ pour le texte
      text_field = line_container.text({
                                         id: "text_#{index}".to_sym,
                                         data: text.to_s,
                                         component: { size: 14 },
                                         edit: true,
                                         width: 300,
                                         position: :absolute,
                                         left: 90,
                                         top: 10,
                                         color: :white
                                       })

      #actions
      timecode_field.keyboard(:dowm) do |native_event|
        event = Native(native_event)
        if event[:keyCode].to_s == '13'
          event.preventDefault
          old_timecode = timecode
          new_timecode = timecode_field.data.to_i
          new_text = text_field.data

          if new_timecode != old_timecode
            lyrics.content.delete(old_timecode)
            lyrics.content[new_timecode] = new_text
          else
            lyrics.content[old_timecode] = new_text
          end

          line_container.blink(:green)
          counter = grab(:counter)
          current_position = counter.timer[:position]
          update_lyrics(current_position, lyrics, counter)

          max_timecode = lyrics.content.keys.max
          if max_timecode > @length
            @length = max_timecode
            full_refresh_viewer(current_position)
          end
          prev_position = @actual_position
          # full_refresh_viewer(0)
          # full_refresh_viewer(@length)
          full_refresh_viewer(prev_position)
        end
      end

      text_field.keyboard(:dowm) do |native_event|
        event = Native(native_event)
        if event[:keyCode].to_s == '13'
          event.preventDefault
          old_timecode = timecode
          new_timecode = timecode_field.data.to_i
          new_text = text_field.data

          if new_timecode != old_timecode
            lyrics.content.delete(old_timecode)
            lyrics.content[new_timecode] = new_text
          else
            lyrics.content[old_timecode] = new_text
          end

          line_container.blink(:green)
          counter = grab(:counter)
          current_position = counter.timer[:position]
          update_lyrics(current_position, lyrics, counter)

          max_timecode = lyrics.content.keys.max
          if max_timecode > @length
            @length = max_timecode
            full_refresh_viewer(current_position)
          end
          prev_position = @actual_position
          # full_refresh_viewer(0)
          # full_refresh_viewer(@length)
          full_refresh_viewer(prev_position)
        end
      end

      # Bouton de mise à jour
      update_button = line_container.box({
                                           width: 25,
                                           height: 25,
                                           left: 400,
                                           top: 10,
                                           color: :green,
                                           smooth: 5
                                         })
      update_button.text({
                           data: "✓",
                           component: { size: 12 },
                           position: :absolute,
                           color: :white,
                           left: 7,
                           top: 5
                         })

      # Bouton de suppression
      delete_button = line_container.box({
                                           width: 25,
                                           height: 25,
                                           left: 435,
                                           top: 10,
                                           color: :red,
                                           smooth: 5
                                         })
      delete_button.text({
                           data: "✗",
                           component: { size: 12 },
                           position: :absolute,
                           color: :white,
                           left: 7,
                           top: 5
                         })

      # Logique de mise à jour
      update_button.touch(true) do
        old_timecode = timecode
        new_timecode = timecode_field.data.to_i
        new_text = text_field.data

        if new_timecode != old_timecode
          # Si le timecode a changé, on supprime l'ancien et on ajoute le nouveau
          lyrics.content.delete(old_timecode)
          lyrics.content[new_timecode] = new_text
        else
          # Sinon on met simplement à jour le texte
          lyrics.content[old_timecode] = new_text
        end

        # Notification visuelle de mise à jour
        line_container.blink(:green)

        # Mise à jour de l'affichage et du slider si nécessaire
        counter = grab(:counter)
        current_position = counter.timer[:position]
        update_lyrics(current_position, lyrics, counter)

        # Reconstruire le slider si la plage a changé
        max_timecode = lyrics.content.keys.max
        if max_timecode > @length
          @length = max_timecode
          full_refresh_viewer(current_position)
        end
        prev_position = @actual_position
        # full_refresh_viewer(0)
        # full_refresh_viewer(@length)
        full_refresh_viewer(prev_position)
      end

      # Logique de suppression
      delete_button.touch(true) do

        prev_left=editor_container.left
        prev_top=editor_container.top
        lyrics.content.delete(timecode)


          line_container.delete({ recursive: true })

          # Réorganiser les éléments restants
          editor_container.delete({ recursive: true })
          show_lyrics_editor(prev_left, prev_top)

          # Mise à jour de l'affichage
          counter = grab(:counter)
          current_position = counter.timer[:position]
          update_lyrics(current_position, lyrics, counter)

          # Reconstruire le slider
          full_refresh_viewer(current_position)
        end
      # end
    end

    # Bouton pour ajouter une nouvelle ligne
    add_button = editor_container.box({
                                        width: 470,
                                        height: 40,
                                        left: 10,
                                        top: 50 + (sorted_lyrics.size * 60),
                                        color: :darkgreen,
                                        smooth: 6
                                      })
    add_button.text({
                      data: "+ Add a new line",
                      component: { size: 14 },
                      position: :absolute,
                      color: :white,
                      left: 160,
                      top: 10
                    })

    add_button.touch(true) do
      # Ouvrir un dialogue pour ajouter une nouvelle ligne
      dialog_container = grab(:view).box({
                                           id: :add_dialog,
                                           width: 300,
                                           height: 150,
                                           left: 500,
                                           top: 250,
                                           position: :absolute,
                                           color: { red: 0.2, green: 0.2, blue: 0.25 },
                                           smooth: 10,
                                           shadow: { blur: 10, alpha: 0.8 }
                                         })

      dialog_container.text({
                              data: "Add a new line",
                              component: { size: 16 },
                              position: :absolute,
                              color: :white,
                              left: 10,
                              top: 10
                            })

      # Champ pour le nouveau timecode
      dialog_container.text({
                              data: "Timecode:",
                              component: { size: 14 },
                              position: :absolute,
                              color: :white,
                              left: 10,
                              top: 40
                            })
      new_timecode_field = dialog_container.text({
                                                   id: :new_timecode,
                                                   data: 120,
                                                   component: { size: 14 },
                                                   edit: true,
                                                   width: 200,
                                                   position: :absolute,
                                                   left: 90,
                                                   top: 40,
                                                   color: :yellow
                                                 })



      # Champ pour le nouveau texte
      dialog_container.text({
                              data: "Texte:",
                              component: { size: 14 },
                              position: :absolute,
                              color: :white,
                              left: 10,
                              top: 70
                            })
      new_text_field = dialog_container.text({
                                               id: :new_text,
                                               data: "Dummy text",
                                               component: { size: 14 },
                                               edit: true,
                                               width: 200,
                                               position: :absolute,
                                               left: 90,
                                               top: 70,
                                               color: :white
                                             })

      # Boutons d'action
      confirm_button = dialog_container.box({
                                              width: 120,
                                              height: 30,
                                              left: 30,
                                              top: 110,
                                              color: :green,
                                              smooth: 5
                                            })
      confirm_button.text({
                            data: "Confirmer",
                            component: { size: 14 },
                            position: :absolute,
                            color: :white,
                            left: 30,
                            top: 5
                          })

      cancel_button = dialog_container.box({
                                             width: 120,
                                             height: 30,
                                             left: 160,
                                             top: 110,
                                             color: :gray,
                                             smooth: 5
                                           })
      cancel_button.text({
                           data: "Annuler",
                           component: { size: 14 },
                           position: :absolute,
                           color: :white,
                           left: 35,
                           top: 5
                         })

      # Action de confirmation
      confirm_button.touch(true) do
        prev_left=editor_container.left
        prev_top=editor_container.top
        new_timecode = new_timecode_field.data.to_i
        new_text = new_text_field.data

        if new_timecode > 0 && !new_text.empty?
          lyrics.content[new_timecode] = new_text

          # Mise à jour de l'affichage
          counter = grab(:counter)
          current_position = counter.timer[:position]
          update_lyrics(current_position, lyrics, counter)

          # Mettre à jour la longueur si nécessaire
          if new_timecode > @length
            @length = new_timecode
          end

          # Reconstruire le slider et l'éditeur
          full_refresh_viewer(current_position)
          dialog_container.delete({ recursive: true })
          editor_container.delete({ recursive: true })
          show_lyrics_editor(prev_left, prev_top)
        else
          # Notification d'erreur
          dialog_container.blink(:red)
        end
      end

      cancel_button.touch(true) do
        dialog_container.delete({ recursive: true })
      end
    end
  end
end