# frozen_string_literal: true

require "./test_helper"

class TestAtome < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Atome::VERSION
  end

  # def setup
  #   # Initialisation des Atomes avant chaque test
  #   @a = box
  #   @b = circle
  #   @t = text("Test")
  # end
  #
  # def test_left_particle_with_box
  #   # Application de la particule `left` et vérification de la position
  #   @a.left(33)
  #   assert_equal(33, @a.left, "La box devrait être déplacée à 33px à gauche")
  # end
  #
  # def test_left_particle_with_circle
  #   # Application de la particule `left` et vérification de la position
  #   @b.left(66)
  #   assert_equal(66, @b.left, "Le circle devrait être déplacé à 66px à gauche")
  # end
  #
  # def test_left_particle_with_text
  #   # Application de la particule `left` et vérification de la position
  #   @t.left(99)
  #   assert_equal(99, @t.left, "Le text devrait être déplacé à 99px à gauche")
  # end
  #
  # def test_it_does_something_useful
  #   assert false
  # end
end
