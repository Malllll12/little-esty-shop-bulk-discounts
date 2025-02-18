require 'rails_helper'

RSpec.describe "Bulk Discounts show page" do
  it "shows the bulk discount's quantity threshold and percentage discount" do
    merch_1 = Merchant.create!(name: "Shop Here")
    merch_2 = Merchant.create!(name: "Buy Here")

    discount_a = merch_1.bulk_discounts.create({name:"Discount A", percentage: 20, threshold: 10 })
    discount_b = merch_1.bulk_discounts.create({name:"Discount B", percentage: 30, threshold: 15 })
    discount_c = merch_2.bulk_discounts.create({name:"Discount C", percentage: 25, threshold: 25 })

    visit merchant_bulk_discount_path(merch_1.id, discount_a.id)

    expect(page).to have_content(discount_a.percentage)
    expect(page).to have_content(discount_a.threshold)
  end

  it 'links to discount edit page' do
    merch_1 = Merchant.create!(name: "Shop Here")
    merch_2 = Merchant.create!(name: "Buy Here")

    discount_a = merch_1.bulk_discounts.create({name:"Discount A", percentage: 20, threshold: 10 })
    discount_b = merch_1.bulk_discounts.create({name:"Discount B", percentage: 30, threshold: 15 })
    discount_c = merch_2.bulk_discounts.create({name:"Discount C", percentage: 25, threshold: 25 })

    visit merchant_bulk_discount_path(merch_1.id, discount_a.id)

    expect(page).to have_link("Edit Discount")
    click_link "Edit Discount"
    expect(current_path).to eq(edit_merchant_bulk_discount_path(merch_1.id, discount_a.id))
  end
end
