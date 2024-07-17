# frozen_string_literal: true


def contact_template
{ id: :humans, role: nil, date: { companies: [], project: {}, events: {}, last_name: nil, first_name: nil ,
                                  emails: { home: nil }, phones: {}, address: {}, groups: [] } }
end


element({id: :testing, data: contact_template})
# grab(:testing).data(contact_template)


wait 2 do
  grab(:testing).data
end
