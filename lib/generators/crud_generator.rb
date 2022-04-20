require 'rails'

class CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  argument :attributes, type: :array, default: [], banner: 'attributes'

  check_class_collision

  class_option :parent, type: :string, desc: "The parent class for the generated model"

  desc "This generator creates a migration"
  def create_migration_file
    raw_attrs = attributes.map { |attr| "#{attr.name}:#{attr.type}" }
    generate 'migration', "Create#{class_name.pluralize.classify}", *raw_attrs, migration_name: "create_#{table_name}"
  end

  desc "This generator creates a model"
  def create_model_file
    template "active_record/model/model.rb.tt", "app/model/#{file_name}.rb"
  end

  def create_factory_file
    # TODO: guardare factory bot come fa?
  end

  def create_model_spec_file
    # TODO: Implement this
  end

  desc "This generator creates a controller"
  def create_controller_file
    template "active_record/controller/api_controller.rb.tt", "app/controllers/api/v1/#{table_name}_controller.rb"
  end

  def create_rswag_file
    # TODO: Implement this
  end

  desc "This generator creates a serializer"
  def create_serializer_file
    template "active_record/serializer/serializer.rb.tt", "app/serializers/#{file_name}.rb"
  end

  def create_routes_file
    # TODO: Aggiungere alle rotte il api_resources
  end

  private

  def permitted_params
    attributes.map { |attr| ":#{attr.name}" }.join(',')
  end

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
