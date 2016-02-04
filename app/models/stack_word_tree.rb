class StackWordTree < ActiveRecord::Base
  after_create :generate_random_name

  private
  def generate_random_name
    self.name = "#{Faker::App.name} Tree"
    save
  end
end
