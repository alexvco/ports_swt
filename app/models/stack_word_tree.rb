class StackWordTree < ActiveRecord::Base
  class NoDataFiledError < StandardError; end

  serialize :result, Array
  mount_uploader :data_file, ::DataFileUploader

  validates :data_file, presence: true

  after_create :generate_random_name

  def find_longest_stack_tree
    ensure_data_file_exists!
    self.result = Dictionary.new(data_file.file.file).find_longest_word_stacked_tree
    save
  end

  private

  def generate_random_name
    self.name = "#{Faker::App.name} Tree"
    save
  end

  def ensure_data_file_exists!
    fail NoDataFiledError, "No data file provided" if data_file.blank?
  end
end
