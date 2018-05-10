require "yaml"

root = File.dirname(__FILE__)
fixtures = "#{root}/../fixtures"
$banlist = "#{fixtures}/banlist.yml"
$style_root = fixtures

require_relative "../../helpers/content_helpers"

RSpec.describe "Tests Module: ContentHelpers" do

    content = ContentHelpers.get_content(fixtures)

    it "Tests variable $banlist: Verifies exclusion" do
        expect(content.length).not_to eq 7
        expect(content).not_to include "#{fixtures}/md-2.md"
    end

    it "Tests method time_sort: Correctly sorts by mtime" do
        ContentHelpers.time_sort(content)

        expect(content.first).to eq "#{fixtures}/md-7.md"
        expect(content.last).to eq "#{fixtures}/md-1.md"
    end

    just6 = []
    for i in 1..7
        just6 << "#{fixtures}/md-#{i}.md" if i != 2
    end
    ContentHelpers.time_sort(just6)

    it "Tests method get_content: Correctly retrieves content" do
        expect(content.length).to eq 6
        expect(content).to eq just6
    end

    it "Tests method get_post: Correctly retrieves post" do
        post = ContentHelpers.get_post(fixtures, "md-4")
        ContentHelpers.time_sort(post)

        expect(post.length).to eq 1
        expect(post).to eq [ "#{fixtures}/md-4.md" ]
    end

    path = "https://www.testDomain.com/fake"

    it "Tests method mp_eu: Correctly adds a param" do
        params = { "mode" => "test" }
        newParams = { "action" => "add" }
        newUrl = ContentHelpers.mp_eu(path, params, newParams)

        expect(newUrl).not_to eq path
        expect(newUrl).not_to eq "#{path}?mode=test"
        expect(newUrl).to eq "#{path}?mode=test&action=add"
    end

    it "Tests method mp_eu: Correctly replaces a param" do
        params = { "action" => "add", "mode" => "test" }
        newParams = { "action" => "remove" }
        newUrl = ContentHelpers.mp_eu(path, params, newParams)

        expect(newUrl).not_to eq "#{path}?action=add&mode=test"
        expect(newUrl).to eq "#{path}?action=remove&mode=test"
    end

    it "Tests method paginate: Correctly retrieves first page" do
        params = {}
        paginated = ContentHelpers.paginate(just6, params, path)

        expect(paginated[:page]).to eq 1
        expect(paginated[:pages]).to eq 2
        expect(paginated[:content].length).to eq 5
        expect(paginated[:pageUrls]).to eq [
            nil,
            nil,
            "/fake?page=2",
            "/fake?page=2"
        ]

        params2 = { "page" => "1" }
        paginated2 = ContentHelpers.paginate(just6, params2, path)

        expect(paginated2[:page]).to eq 1
        expect(paginated2[:pages]).to eq 2
        expect(paginated2[:content].length).to eq 5
        expect(paginated2[:pageUrls]).to eq [
            nil,
            nil,
            "/fake?page=2",
            "/fake?page=2"
        ]
    end

    it "Tests method paginate: Correctly retrieves second page" do
        params = { "page" => "2" }
        paginated = ContentHelpers.paginate(just6, params, path)

        expect(paginated[:page]).to eq 2
        expect(paginated[:pages]).to eq 2
        expect(paginated[:content].length).to eq 1
        expect(paginated[:pageUrls]).to eq [
            "/fake?page=1",
            "/fake?page=1",
            nil,
            nil
        ]
    end

end