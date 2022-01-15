require 'rails_helper'

RSpec.describe "Bulk Discounts Index page" do
  it 'displays discount info' do
    merch_1 = Merchant.create!(name: "Shop Here")
    merch_2 = Merchant.create!(name: "Buy Here")

    discount_a = merch_1.bulk_discounts.create({name:"Discount A", discount: 20, threshold: 10 })
    discount_b = merch_1.bulk_discounts.create({name:"Discount B", discount: 30, threshold: 15 })
    discount_c = merch_2.bulk_discounts.create({name:"Discount C", discount: 25, threshold: 25 })

    visit "/merchants/#{merch_1.id}/bulk_discounts/"

    expect(page).to have_content(discount_a.name)
    expect(page).to have_content(discount_b.name)
    expect(page).to_not have_content(discount_c.name)
    expect(page).to have_content("%20")
    expect(page).to have_content("%30")
    expect(page).to_not have_content("%25")
    expect(page).to have_content(discount_a.threshold)
    expect(page).to have_content(discount_b.threshold)
    expect(page).to_not have_content(discount_c.threshold)
  end

  it "links to discount show page" do
    merch_1 = Merchant.create!(name: "Shop Here")
    merch_2 = Merchant.create!(name: "Buy Here")

    discount_a = merch_1.bulk_discounts.create({name:"Discount A", discount: 20, threshold: 10 })
    discount_b = merch_1.bulk_discounts.create({name:"Discount B", discount: 30, threshold: 15 })
    discount_c = merch_2.bulk_discounts.create({name:"Discount C", discount: 25, threshold: 20 })

    visit "/merchants/#{merch_1.id}/bulk_discounts/"

    expect(page).to have_content(discount_a.name)
    click_link "#{discount_a.name}"
    expect(current_path).to eq("/merchants/#{merch_1.id}/bulk_discounts/#{discount_a.id}")
  end

  it 'links to a create form' do
    merch_1 = Merchant.create!(name: "Shop Here")
    merch_2 = Merchant.create!(name: "Buy Here")

    discount_a = merch_1.bulk_discounts.create({name:"Discount A", discount: 20, threshold: 10 })
    discount_b = merch_1.bulk_discounts.create({name:"Discount B", discount: 30, threshold: 15 })
    discount_c = merch_2.bulk_discounts.create({name:"Discount C", discount: 25, threshold: 20 })

    visit "/merchants/#{merch_1.id}/bulk_discounts/"
    click_link "New Discount"
    expect(current_path).to eq("/merchants/#{merch_1.id}/bulk_discounts/new")
  end
end

# Merchant Bulk Discount Create
#
# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
