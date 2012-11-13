require 'spec_helper'

describe Invitation do
  it '' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    event1 = create(:event, host: user1, invitations_attributes: [
      { invitee: {email: 'rainux@gmail.com', name: 'Rainux Luo' } },
      { invitee: {email: 'me@rainux.org', name: 'Rainux Luo' } }
    ])
    event2 = create(:event, host: user2, invitations_attributes: [
      { invitee: {email: 'rainux@gmail.com', name: 'Rainux Luo' } },
      { invitee: {email: 'me@rainux.org', name: 'Rainux Luo' } }
    ])
    ap Event.all.as_json
    ap Event.elem_match(invitations: {invitee_id: user3.id}).to_a
    # event1.invite(user1)
  end
end
