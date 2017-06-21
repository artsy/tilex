defmodule Features.VisitorViewsDeveloper do
  use Tilex.IntegrationCase, async: true

  test "and sees the developer's posts", %{session: session} do

    developer = Factory.insert!(:developer, username: "makinpancakes")
    post = Factory.insert!(:post, title: "A special post", developer: developer)

    visit(session, post_path(Endpoint, :show, post))
      |> find(Query.css("body"))

    click(session, Query.link("makinpancakes"))

    page_header = Element.text(find(session, Query.css(".page_head")))

    assert page_header =~ ~r/1 post by makinpancakes/
    assert find(session, Query.css("article.post"))
    assert page_title(session) == "Today I Learned - Hashrocket - makinpancakes"
  end

  test "and sees a prolific developer's posts", %{session: session} do

    developer = Factory.insert!(:developer, username: "banjocardhush")

    1..55
      |> Enum.each(fn(_i) ->
        Factory.insert!(:post, developer: developer)
      end)

    visit(session, developer_path(Endpoint, :show, developer))

    page_header = Element.text(find(session, Query.css(".page_head")))
    assert page_header =~ ~r/55 posts by banjocardhush/
  end

  test "and sees the developer's twitter when set", %{session: session} do
    developer = Factory.insert!(:developer, twitter_handle: "makinbaconpancakes")

    visit(session, developer_path(Endpoint, :show, developer))

    assert has?(session, Query.link("@makinbaconpancakes"))
  end
end