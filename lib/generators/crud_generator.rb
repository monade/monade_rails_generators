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
    template "active_record/model/model.rb.tt", "app/models/#{file_name}.rb"
  end

  desc "This generates the model unit test file"
  def create_model_spec_file
    template "rspec/model/model_spec.rb.tt", "spec/models/#{file_name}_spec.rb"
  end

  desc "this generates the factory bot model"
  def create_factory_file
    template "rspec/factory_bot/factory_bot.rb.tt", "spec/factories/#{class_name.gsub("::", "").pluralize.underscore}.rb"
  end

  def create_controller_file
    # TODO: Implement this
  end

  def create_rswag_file
    # TODO: Implement this
  end

  def create_serializer_file
    # TODO: Guardare active model serializer come fa?
  end

  def create_routes_file
    # TODO: Aggiungere alle rotte il api_resources
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
