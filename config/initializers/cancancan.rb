if defined?(CanCan)
  class Object
    def metaclass
      class << self; self; end
    end
  end

  module CanCan
    module ModelAdapters
      class ActiveRecord4Adapter < ActiveRecordAdapter
        def self.find(model_class, id)
          klass =
          model_class.metaclass.ancestors.include?(ActiveRecord::Associations::CollectionProxy) ?
            model_class.klass : model_class
          if id.to_i.to_s == id
            model_class.find id
          else
            model_class.find_by_slug(id)
          end
        end
      end
    end
  end
end
