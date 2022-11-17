# frozen_string_literal: true

# for opal rendering
class Atome
  private

  def opal_document
    $document
  end

  def opal_attach_shape(parents)
    @html_object.append_to(opal_document[parents])
  end

  def opal_attach_color(parents)
    opal_document[parents].add_class(@atome[:id])
  end
end
