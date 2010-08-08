!SLIDE
# How?


!SLIDE bullets
# Ingredients (buzzwords!)

* Monkey patching
* Reflection
* DSLs
* Code generation
* Functional programming
* Cucumber
* Egregious hacks


!SLIDE
# Step 1: monkeys!

    @@@ ruby
    VALIDATION_TYPES.each do |validation_type|
      define_method "validates_#{validation_type}_of" do |*attr_names|
        super(*attr_names)
        options = extract_options_from_array(attr_names)
        attr_names.each do |attribute|
          key = attribute.to_sym
          reflection = Reflections.create(validation_type, self, key, options)
          validations[key] ||= []
          validations[key] << reflection
        end
      end
    end


!SLIDE
# Step 1: monkeys!

    @@@ ruby
    def Reflections.create(type, model, field, options)
      klass = const_get(type.gsub(/^(.)/) { $1.upcase })
      klass.new(model, field, options)
    end


!SLIDE
# Step 2: more monkeys

    @@@ ruby
    class ActionView::Helpers::FormBuilder  
      old_initialize = instance_method(:initialize)
      
      define_method(:initialize) do |object_name, object, template, *args|
        @acceptance_builder = template.acceptance_builder
        @acceptance_builder.set_object(object, object_name)
        old_initialize.bind(self).call(object_name, object, template, *args)
      end
    end


!SLIDE
# Step 2: more monkeys

    @@@ ruby
    class ActionView::Helpers::FormBuilder  
      TAG_HELPERS.each do |helper|
        old_helper = instance_method(helper)
        
        define_method(helper) do |*args|
          @acceptance_builder.add_field(args.first)
          old_helper.bind(self).call(*args)
        end
      end
    end


!SLIDE
# Step 2: more monkeys

    @@@ ruby
    module ActionView::Helpers::FormTagHelper
      old_html_options_for_form = instance_method(:html_options_for_form)
      
    private
      define_method(:html_options_for_form) do |*args|
        options = old_html_options_for_form.bind(self).call(*args)
        acceptance_builder.form = options['id']
        options
      end
    end


!SLIDE
# Step 3: reflect and generate

    @@@ ruby
    class Acceptance::Generator
      def validations
        @object.reflect_on_all_validations.select do |v|
          @fields.include?(v.field.to_sym)
        end
      end
      
      def generate_script
        ERB.new(TEMPLATE).result(binding)
      end
    end


!SLIDE
# Step 3: reflect and generate

    @@@ ruby
    class Acceptance::Generator
      TEMPLATE = <<-JAVASCRIPT
      <script type="text/javascript" id="<%= form_id %>_validation">
      (function() {
        <% validations.each do |validation| %>
          <%= generate_code_for validation %>
        <% end %>
      })();
      </script>
      JAVASCRIPT
    end


!SLIDE
# Step 3: reflect and generate

    @@@ ruby
    class Acceptance::Generator
      validate :acceptance do |validation|
        <<-SCRIPT
        Acceptance.form('#{ form_id }').
        requires(#{ field_name_for validation }).
        toBeChecked(#{ message_for validation });
        SCRIPT
      end
    end


!SLIDE
# Step 4: the target DSL

    @@@ javascript
    Acceptance.Requirement.prototype.
    toBeChecked = function(message) {
      this._field.addTest(function(result, validation) {
        var input = validation.getInput();
        result( input.checked || [message] );
      });
      return this;
    };

`result` is a continuation: returning like this means we can
support asynchronous validation, e.g. uniqueness checks over XHR.


!SLIDE
# Step 5: hack the DOM

    @@@ javascript
    Acceptance.Form = Acceptance.Class({
      initialize: function(id) {
        this._form = document.getElementById(id);
        Event.on(this._form, 'submit', this.handleSubmit, this);
      },
      
      handleSubmit: function(event) {
        event.stopDefault();
        this.isValid(function(valid) {
          this._form.submit();
        }, this);
      }
    });


!SLIDE
# Step 6: continuations

    @@@ javascript
    Acceptance.Form.prototype.
    isValid = function(callback, scope) {
      var valid = true,
          n = this._fields.length,
          i = 0;
      
      this._fields.forEach(function(field) {
        field.isValid(function(fieldValid) {
          if (!fieldValid) valid = false;
          i += 1;
          if (i === n) callback.call(scope, valid);
        });
      });
    };


!SLIDE
# Step 6: continuations

    @@@ javascript
    Acceptance.Field.prototype.
    isValid = function(callback, scope) {
      var validation = new Acceptance.Validation(this),
          tests      = this._tests,
          isValid    = true;
      
      tests.forEach(function(test) {
        test(function(result) {
          // Handle test result
          // call callback.call(scope, isValid) if all done
        }, validation);
      });
    };
