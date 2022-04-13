require 'rails_helper'

RSpec.feature "Usernavigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "User clicks on a specific product" do
    
    visit root_path

    page.find(:xpath, "/html/body/main/section/div/article[1]/header/a").click
   

    expect(page).to have_css('.products-show')
    #save_screenshot
  end
end