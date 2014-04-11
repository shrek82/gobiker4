json.array!(@topics) do |topic|
  json.extract! topic, :id, :forum_id, :subject_id, :title, :title_color, :user_id, :is_fixed, :is_good, :is_recommend, :hits_num, :comments_num, :last_comment_user_id, :last_comment_time
  json.url topic_url(topic, format: :json)
end
