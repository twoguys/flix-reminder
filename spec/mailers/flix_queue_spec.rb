require "spec_helper"

describe FlixQueue do
  describe "show_queue" do
    let(:mail) { FlixQueue.show_queue }

    it "renders the headers" do
      mail.subject.should eq("Show queue")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
