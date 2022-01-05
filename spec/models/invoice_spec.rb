require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  before(:each) do
    @merch_1 = Merchant.create!(name: "Shop Here")

    @item_1 = Item.create!(name:"jumprope", description:"Pink and sparkly.", unit_price:600, merchant_id:"#{@merch_1.id}")
    @item_2 = Item.create!(name:"hula hoop", description:"Get your groove on!", unit_price:700, merchant_id:"#{@merch_1.id}")
    
    @cust_1 = Customer.create!(first_name:"Hannah", last_name:"Warner")
    
    @invoice_1 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
    @invoice_2 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
    @invoice_3 = Invoice.create!(customer_id:"#{@cust_1.id}", status:1)
        
    @invoice_item_1 = InvoiceItem.create!(invoice_id:"#{@invoice_1.id}", item_id:"#{@item_1.id}", status: 2, quantity:1, unit_price:600)
    @invoice_item_2 = InvoiceItem.create!(invoice_id:"#{@invoice_2.id}", item_id:"#{@item_2.id}", status: 2, quantity:1, unit_price:700)
    @invoice_item_3 = InvoiceItem.create!(invoice_id:"#{@invoice_3.id}", item_id:"#{@item_2.id}", status: 2, quantity:1, unit_price:700)
  end

  it "returns merchants invoices" do 
    expect(Invoice.merchants_invoices(@merch_1)).to eq([@invoice_1, @invoice_2, @invoice_3])
  end

end
