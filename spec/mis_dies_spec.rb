require_relative '../lib/mis_dies'

RSpec.describe 'mis_dies' do
  it 'gives a +1 to a PR' do
    repo = 'a_user/a_repo'
    pull_request = '1'
    token = 'a_token'

    mis_dies = MisDies.new(repo, pull_request, token)

    stub_request(:post, "https://api.github.com/repos/a_user/a_repo/pulls/1/reviews")
      .with( body: "{\"event\":\"APPROVE\"}", headers: { 'Authorization'=>'token a_token' })
      .to_return(status: 200, body: aproved_pull_request.to_json)

    response = mis_dies.give_plus_one

    expect(response[:user][:login]).to eq "another_user"
    expect(response[:state]).to eq "APPROVED"
  end

  def aproved_pull_request
    {
      id: 95268605,
      user: {
        login: "another_user",
        id: 35934054,
        type: "User",
        site_admin: false
      },
      body: "",
      state: "APPROVED",
      html_url: "https://github.com/a_user/a_repo/pull/1#pullrequestreview-95268605",
      pull_request_url: "https://api.github.com/repos/a_user/a_repo/pulls/1",
      author_association: "COLLABORATOR",
      _links: {
        html: {
          href: "https://github.com/a_user/a_repo/pull/1#pullrequestreview-95268605"
        },
        pull_request: {
          href: "https://api.github.com/repos/a_user/a_repo/pulls/1"
        }
      },
      submitted_at: "2018-02-08T23:16:58Z",
      commit_id: "6d7a15188202ee15b468909af9562e4b4708ba9a"
    }
  end
end
