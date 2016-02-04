class StackWordTree < ActiveRecord::Base
  serialize :result, Array
  mount_uploader :data_file, ::DataFileUploader

  after_create :generate_random_name

  private
  def generate_random_name
    self.name = "#{Faker::App.name} Tree"
    save
  end
end
