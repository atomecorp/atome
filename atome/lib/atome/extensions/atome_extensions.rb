class Atome

  def atomes(full_list=false)
    atomes_found=[]
    system_atomes=[:atome,:preset, :black_hole, :device, :intuition,:view, :messenger, :authorization, :buffer, "UI"]
    @@atomes.each do |atome_identity, atome_content|
      if full_list
        atomes_found<<atome_identity
      else
        if !system_atomes.include?(atome_identity)
          atomes_found<<atome_identity
        end
      end
    end
    atomes_found
  end

  def address(&proc)
    address_html(&proc)
  end
end