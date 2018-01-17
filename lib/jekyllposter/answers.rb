class Answers
  attr :type
  attr :title, :tags, :categories, :file_string, :date_string, :dt_string, :layout, :file_type
  attr :slug

  def initialize(type)
    @type = type
    @layout = type
    @title = nil
    @tags = nil
    @categories = nil
    @date_string = nil
    @dt_string = nil
    @file_type = nil
    @slug = nil
  end
end
