require 'rails'

class CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  argument :attributes, type: :array, default: [], banner: 'attributes'

  check_class_collision

  class_option :parent, type: :string, desc: "The parent class for the generated model"

  desc "This generator creates a crud"
  def create_crud_file
    # fail 'funziona'
    # create_file "app/model/test.rb", "CIAO"
    template "active_record/model/model.rb.tt", "app/model/#{file_name}.rb"
  end

  private

  def parent_class_name
    if parent
      parent
    # elsif database
    #   abstract_class_name
    else
      "ApplicationRecord"
    end
  end

  def parent
    options[:parent]
  end
end
