require "rails"

class CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  argument :attributes, type: :array, default: [], banner: "attributes"

  check_class_collision

  class_option :authenticated, type: :boolean, default: false
  class_option :parent, type: :string, desc: "The parent class for the generated model"

  desc "This generator creates a migration"
  def create_migration_file
    raw_attrs = attributes.map { |attr| "#{attr.name}:#{attr.type}" }
    generate "migration", "Create#{table_name_with_namespace.classify.pluralize}", *raw_attrs,
             migration_name: "create_#{table_name_with_namespace.underscore.pluralize}"
  end

  desc "This generator creates a model"
  def create_model_file
    template "active_record/model/model.rb.tt", "app/models/#{file_path}.rb"
    return if regular_class_path.empty?

    template "active_record/model/namespace.rb.tt", "app/models/#{regular_class_path[0]}.rb"
  end

  desc "This generates the model unit test file"
  def create_model_spec_file
    template "rspec/model/model_spec.rb.tt", "spec/models/#{file_path}_spec.rb"
  end

  desc "this generates the factory bot model"
  def create_factory_file
    template "rspec/factory_bot/factory_bot.rb.tt",
             "spec/factories/#{file_path.pluralize}.rb"
  end

  desc "This generator creates a controller"
  def create_controller_file
    template "active_record/controller/api_controller.rb.tt", "app/controllers/v1/#{file_path.pluralize}_controller.rb"
  end

  desc "This generates the rswag test file"
  def create_rswag_file
    if options["authenticated"]
      template "rspec/request/authenticated_request_spec.rb.tt", "spec/requests/v1/#{file_path}_spec.rb"
    else
      template "rspec/request/request_spec.rb.tt", "spec/requests/v1/#{file_path.pluralize}_spec.rb"
    end
  end

  desc "This generator creates a serializer"
  def create_serializer_file
    template "active_record/serializer/serializer.rb.tt", "app/serializers/#{file_path}_serializer.rb"
  end

  desc "This generator declares the model in cancancan"
  def create_ability_file
    template "cancancan/ability/ability.rb.tt", "app/models/ability.rb" unless File.exist?("app/models/ability.rb")
    spy = if options["authenticated"]
            "def define_authenticated_abilities!(user)\n"
          else
            "def initialize(user)\n"
          end

    code = "    can :manage, #{class_name}\n"

    inject_into_file "app/models/ability.rb", code, after: spy, verbose: false, force: false
  end

  desc "This generator defines a resource"
  def create_routes_file
    route "api_resources :#{file_name.pluralize}", namespace: ["v1"] + regular_class_path
  end

  private

  def table_name_with_namespace
    class_name.gsub("::", "").pluralize
  end

  def permitted_params
    attributes.map { |attr| ":#{attr.name}" }.join(",")
  end

  def parent_class_name
    parent || "ApplicationRecord"
  end

  def parent
    options[:parent]
  end
end
