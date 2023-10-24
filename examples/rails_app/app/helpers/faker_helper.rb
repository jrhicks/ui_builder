module FakerHelper
  def lorem_ipsom
    data = [
      Faker::Lorem.paragraph_by_chars(number: 200, supplemental: true),
      Faker::Lorem.paragraph_by_chars(number: 200, supplemental: true),
    ]
    data.map { |p| "<p>#{p}</p><br />" }.join("\n").html_safe
  end
end