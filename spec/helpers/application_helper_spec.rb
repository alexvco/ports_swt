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

  context "#create_json_tree" do
    it "creates a json version of the tree result for d3" do
      stack_word_tree1 = create(:stack_word_tree, result: ["ire", "rite", "trite", "titres", "tinters"])
      stack_word_tree2 = create(:stack_word_tree, result: ["ton", "snot", "notes", "lentos", "tolanes", "elations"])

      expect(helper.create_json_tree(stack_word_tree1)).to eq({ name:     "flare",
                                                                children: [{ name: "ire", size: 3 },
                                                                           { name: "rite", size: 4 },
                                                                           { name: "trite", size: 5 },
                                                                           { name: "titres", size: 6 },
                                                                           { name: "tinters", size: 7 }] })

      expect(helper.create_json_tree(stack_word_tree2)).to eq({ name:     "flare",
                                                                children: [{ name: "ton", size: 3 },
                                                                           { name: "snot", size: 4 },
                                                                           { name: "notes", size: 5 },
                                                                           { name: "lentos", size: 6 },
                                                                           { name: "tolanes", size: 7 },
                                                                           { name: "elations", size: 8 }] })
    end
  end
end
