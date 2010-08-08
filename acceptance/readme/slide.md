!SLIDE
# README?


!SLIDE commandline

    $ sudo gem install jake
    $ ./script/plugin install git://github.com/jcoglan/acceptance.git
    $ rake acceptance:install


!SLIDE
# Extend your model

    @@@ ruby
    class User < ActiveRecord::Base
      # before adding your validations
      extend Acceptance::ReflectsOnValidations
    end


!SLIDE
# Add the helper

    @@@ ruby
    module ApplicationHelper
      include Acceptance::FormHelper
    end


!SLIDE
# Validate your forms

    @@@ html
    <% validated_form_for(@user) do |f| %>
      <%= f.text_field :email %>
      <%= f.password_field :password %>
    <% end %>


!SLIDE
# Update your GUI

    @@@ javascript
    Acceptance.onValidation(function(field) {
      var container = jQuery(field.getInput()).parent(),
          errorElem = container.find('.error-message');
      
      errorElem.text(field.getErrorMessages()[0]);
    });

