require_relative "../../helpers/content_helpers"

RSpec.describe "Tests Module: ContentHelpers" do

    it "Method mp_eu: Correctly adds a param" do
        path = "https://www.testDomain.com/fake"
        params = { "mode" => "test" }
        newParams = { "action" => "add" }
        newUrl = ContentHelpers.mp_eu(path, params, newParams)

        expect(newUrl).not_to eq path
        expect(newUrl).not_to eq "#{path}?mode=test"
        expect(newUrl).to eq "#{path}?mode=test&action=add"
    end

    it "Method mp_eu: Correctly replaces a param" do
        path = "https://www.testDomain.com/fake"
        params = { "action" => "add", "mode" => "test" }
        newParams = { "action" => "remove" }
        newUrl = ContentHelpers.mp_eu(path, params, newParams)

        expect(newUrl).not_to eq "#{path}?action=add&mode=test"
        expect(newUrl).to eq "#{path}?action=remove&mode=test"
    end

end