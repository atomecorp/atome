class Atome
  def self.surveiller_instance(instance, methodes_a_surveiller, variables_a_surveiller)
    # Surveiller les méthodes
    methodes_a_surveiller.each do |methode|
      methode_originale = instance.method(methode)
      instance.define_singleton_method(methode) do |*args, &block|
        valeur_avant = instance.instance_variable_get("@#{methode}")
        resultat = methode_originale.call(*args, &block)
        valeur_apres = instance.instance_variable_get("@#{methode}")

        if args.empty?
          puts "Surveillance: Lecture de #{methode}"
        else
          if valeur_avant != valeur_apres
            puts "Surveillance: Modification de #{methode} de #{valeur_avant} à #{valeur_apres}"
          else
            puts "Surveillance: Appel de #{methode} sans modification"
          end
        end

        resultat
      end
    end

    # Surveiller les variables d'instance
    variables_a_surveiller.each do |var|
      # Redéfinir le getter
      instance.define_singleton_method(var) do
        puts "Surveillance: Lecture de #{var}"
        instance_variable_get("@#{var}")
      end

      # Redéfinir le setter
      instance.define_singleton_method("#{var}=") do |value|
        puts "Surveillance: Modification de #{var}"
        instance_variable_set("@#{var}", value)
      end
    end
  end
end

# Votre code pour créer et manipuler les instances
c = circle({ id: :the_circle, left: 122, color: :orange, drag: { move: true, inertia: true, lock: :start } })

wait 2 do
  col = color({ id: :col1, red: 1, blue: 1 })
  Atome.surveiller_instance(col, [:red, :blue], [:variable1, :variable2])

  c.apply([:col1])
  wait 2 do
    puts "before : #{col.inspect}"
    col.red(0)  # Appel en écriture
    col.red     # Appel en lecture
    puts "after : #{col.inspect}"
    c.apply([:col1])
  end
end
