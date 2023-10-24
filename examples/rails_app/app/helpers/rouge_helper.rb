require 'rouge'
module RougeHelper

  def ruby(text)
    rouge('ruby', text)
  end

  def slim(text)
    rouge('slim', text)
  end

  def rouge(language, text)
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    lexer = Rouge::Lexer.find(language)
    formatter.format(lexer.lex(text)).html_safe
  end
end