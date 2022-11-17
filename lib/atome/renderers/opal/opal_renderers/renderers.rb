# frozen_string_literal: true

# for opal rendering
class Atome
  private

  def opal_document
    $document
  end

  def opal_attach_shape(parent)
    @html_object.append_to(opal_document[parent])
  end

  def opal_attach_color(parent)
    opal_document[parent].add_class(@atome[:id])
  end
end
