require 'rails_helper'

describe ApplicationHelper, type: :helper do
  context "#bootstrap_class_for" do
    context "when flash_type is anything other than success, error, alert, notice" do
      it "returns the alert-info class" do
        expect(helper.bootstrap_class_for("other")).to eq("alert-info")
      end
    end

    context "when flash type is either success, error, alert, notice" do
      it "returns the correct class based on flash type" do
        expect(helper.bootstrap_class_for("success")).to eq("alert-success")
        expect(helper.bootstrap_class_for("error")).to eq("alert-danger")
        expect(helper.bootstrap_class_for("alert")).to eq("alert-warning")
        expect(helper.bootstrap_class_for("notice")).to eq("alert-info")
      end
    end
  end
end
