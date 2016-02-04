FactoryGirl.define do
  factory :stack_word_tree do
    name "MyText"
    data_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'no_tree_file.dat')) }
  end
end

