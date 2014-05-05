Paperclip.interpolates :year do |attachment, style|
  return Time.now.strftime('%Y')
end

Paperclip.interpolates :month do |attachment, style|
  return Time.now.strftime('%m')
end

Paperclip.interpolates :day do |attachment, style|
  return Time.now.strftime('%d')
end

Paperclip.interpolates :full_time do |attachment, style|
  return Time.now.strftime('%Y%m%d')
end