class InventorySerializer
  include JSONAPI::Serializer
  attributes :id

  attributes :item do |object|
    {
      item_id: object.item_id,
      item_type: object.item_type,
      name: object.item.name,
      quantity: object.quantity
    }
  end
end
