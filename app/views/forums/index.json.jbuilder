json.array!(@forums) do |forum|
  json.extract! forum, :id, :category_id, :name, :intro, :province_id, :city_id, :club_id, :topics_num, :order_num, :is_systemic, :icon_path
  json.url forum_url(forum, format: :json)
end
