# frozen_string_literal: true

new({ particle: :find }) do |params|
  puts params

end

b = box
# alert 'use category top assign class then port hybrid.html to atom'
16.times do |index|
  width_found = b.width
  b.duplicate({ left: b.left + index * (width_found + 45), top: 0, category: :matrix })
end

def calculate_dynamic_value(particle)
  500
end

b.find(
  condition: [{
                operator: :and,
                rules: [
                  {
                    property: :left,
                    comparison: :gt,
                    value: { type: :dynamic, content:[22] }
                  },
                  {
                    operator: :or,
                    rules: [
                      {
                        property: :width,
                        comparison: :eq,
                        value: { type: :static, content: 50 }
                      },
                      {
                        property: :width,
                        comparison: :eq,
                        value: { type: :static, content: 100 }
                      }
                    ],
                    pre_validate: true
                  },

                ]
              },
              {
                operator: :or,
                rules: [
                  {
                    property: :rotate,
                    comparison: :gt,
                    value: { type: :static, content: 20 }
                  }
                ]
              }]
) do
  alert 'items found'
end


Universe.user_atomes.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.color(:orange)
    atome_found.smooth(200)
    atome_found.top(200)
  end
end
#
random_found =Universe.user_atomes.sample(7)
random_found.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.top(rand(600))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color(:red)
  end
end

random_found =Universe.user_atomes.sample(9)
random_found.each do |atome_id|
  atome_found = grab(atome_id)
  if atome_found.type == :shape
    atome_found.left(rand(700))
    atome_found.width(rand(120))
    atome_found.height(rand(120))
    atome_found.smooth(rand(120))
    atome_found.color(:blue)
  end
end

# List of Comparison Operators
# :eq (Equal To)
# Description: Checks if the value is equal to the specified value.
# Usage: { comparison_operator: :eq, value: 100 } would match if the property's value is exactly 100.
# :gt (Greater Than)
# Description: Checks if the value is greater than the specified value.
# Usage: { comparison_operator: :gt, value: 30 } would match if the property's value is greater than 30.
# :lt (Less Than)
# Description: Checks if the value is less than the specified value.
# Usage: { comparison_operator: :lt, value: 50 } would match if the property's value is less than 50.
# :gte (Greater Than or Equal To)
# Description: Checks if the value is greater than or equal to the specified value.
# Usage: { comparison_operator: :gte, value: 20 } would match if the property's value is 20 or more.
# :lte (Less Than or Equal To)
# Description: Checks if the value is less than or equal to the specified value.
# Usage: { comparison_operator: :lte, value: 60 } would match if the property's value is 60 or less.
# :neq (Not Equal To)
# Description: Checks if the value is not equal to the specified value.
# Usage: { comparison_operator: :neq, value: 45 } would match if the property's value is anything other than 45.
# :in (In a Set Of)
# Description: Checks if the value is within a specified set of values.
# Usage: { comparison_operator: :in, value: [1, 2, 3] } would match if the property's value is either 1, 2, or 3.
# :nin (Not in a Set Of)
# Description: Checks if the value is not within a specified set of values.
# Usage: { comparison_operator: :nin, value: [10, 20, 30] } would match if the property's value is anything other than 10, 20, or 30.

# example :

# b.find(
#   condition: {
#     operator: :and,
#     rules: [
#       {
#         property: :left,
#         comparison: :gt,
#         value: { type: :dynamic, content: -> { calculate_dynamic_value('left') }, cache: true }
#       },
#       {
#         operator: :or,
#         rules: [
#           {
#             property: :width,
#             comparison: :eq,
#             value: { type: :static, content: 50 }
#           },
#           {
#             operator: :and,
#             rules: [
#               {
#                 property: :width,
#                 comparison: :eq,
#                 value: { type: :static, content: 100 }
#               },
#               # ...
#             ]
#           }
#         ],
#         pre_validate: true
#       },
#       # ...
#     ]
#   }
# )