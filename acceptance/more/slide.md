!SLIDE
# More


!SLIDE
# Custom validators

    @@@ javascript
    Acceptance.form('new_user').
    requires('user[email]').
    toBeUnique({model: 'User', field: 'email'},
      'This addresss is already taken');


!SLIDE
# Custom validators

    @@@ javascript
    Acceptance.macro('toBeUnique', function(settings, message) {
      return function(result, validation) {
        var value = validation.getValue(),
            input = validation.getInput();

        if ( !jQuery.trim(value) || !validation.isValid() )
          return result( true );

        var params = Acceptance.extend({value: value}, settings);

        jQuery.get('/model_exists', params, function(response) {
          var exists = (response === 'true');
          result( exists ? [message] : true );
        });
      };
    });


!SLIDE
# Custom validators

    @@@ ruby
    class ValidationGenerator < Acceptance::DefaultGenerator
      validate :uniqueness do |validation|
        <<-SCRIPT
        Acceptance.form('#{ form_id }').
        requires('#{ object_name }[#{ validation.field }]').
        toBeUnique({
          model: '#{ validation.model }',
          field: '#{ validation.field }'
        },
        #{ message_for validation });
        SCRIPT
      end
    end
    Acceptance.generator = ValidationGenerator

