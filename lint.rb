# BNF
#   body := collection
#   collection := [element, ...]
#   element := element | base_type
#   base_type := String | Integer | Float | Boolean

class Register < API
  base 'v1' # We need some root that will tell us if the urls should match an endpoint

  endpoint "stock_items.api"
  endpoint "v1/stock_items" do
    description "..."
    
    get do
      body { element :name, String }
      response 200 { element :ok, Boolean }
      response 400 { element :ok, Boolean }
    end
  end
end

# In another file stock_items.api
endpoint "v1/stock_items" do
  description '...'

  get do # also have post, put, head, etc
    header "User-Agent", format: //
    header "X-Custom-Header", optional: true

    # Should be able to define a parameter listed in the endpoint url
    parameter :uuid, description: '', format: //
    parameter :last_update_token, description: '', format: //

    body do
      element :client, Client
      element :sale, Sale
    end

    response 201 do
      header "Status", format: //
      header "Content-Type", format: //

      body do
        element :ok, Boolean
      end
    end

    response 400, 422 do
      description 'Sale not found'

      header "Status", format: //
      header "Content-Type", format: //

      body do
        element :ok, Boolean
      end
    end
  end
end

class Client < Element
  description = '...'

  element :name, String, description: 'Name of the client'
  element :version, String, description: '...', format: /\d+\.\d+\.\d+/
  element :store, String, description: 'foo-store'
end

class Sale < Element
  description = '...'

  element :employee_id, String, description: "Employee uuid"
  element :sale_date, String, description: "Sale date", format: DateFormatter
  element :shift_id, String, description: "...", format: UuidFormatter
  element :subtotal, BigDecimal, description: "...", validate: lambda { |sale| sale.sold_items.sum { |si| si["total"] } == sale["subtotal"] }
  element :discount, BigDecimal, description: "..."
  element :tax, BigDecimal, description: "..."
  element :total, BigDecimal, description: "..."
  element :receipt_number, Integer, description: "..."
  collection :sold_items, SoldItem, description: "..."
  collection :sale_tenders, SaleTender, description: "..."
  element :receipt, Receipt, description: "..."
  element :foo, String, description: "...", optional: true
end

class UuidFormat < Format
  def validate(value)
    value =~ //
  end

  def example
    "abcd-efgh"
  end
end