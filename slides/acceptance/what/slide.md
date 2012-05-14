!SLIDE
# Acceptance

## Client-side validation for Rails


!SLIDE
# What?


!SLIDE
# Have validations

    @@@ruby
    class User < ActiveRecord::Base
      extend Acceptance::ReflectsOnValidations
      
      validates_format_of :email, :with => /^[a-z0-9@.-]+$/i
      validates_confirmation_of :password
      validates_inclusion_of :gender, :in => %w[M F]
    end


!SLIDE
# Have a form

    @@@html
    <% validated_form_for(@user) do |f| %>
      <%= f.text_field :email %>
      <%= f.password_field :password %>
      <%= f.password_field :password_confirmation %>
      <%= f.text_field :gender %>
      <%= submit_tag('Sign up!') %>
    <% end %>


!SLIDE
# Get JavaScript

    @@@javascript
    Acceptance.form('new_user').
    requires('user[email]').toMatch(/^[a-z0-9@.-]+$/i);
    
    Acceptance.form('new_user').
    requires('user[password_confirmation]').
    toConfirm('user[password]');
    
    Acceptance.form('new_user').
    requires('user[gender]').toBeOneOf(["M", "F"]);


!SLIDE
# What else?


!SLIDE
# Reflect on your validations

    @@@ruby
    v = User.reflect_on_validations_for :email
    # => [ #<Acceptance::Reflections::Presence>,
    #      #<Acceptance::Reflections::Format>,
    #      #<Acceptance::Reflections::Uniqueness>
    #    ]
    
    v[1].with
    # => /^[a-z0-9@.-]+$/i
    
    v[1].message
    # => "Email is invalid."


!SLIDE bullets
# Supports most validations

* `validates_acceptance_of`
* `validates_confirmation_of`
* `validates_exclusion_of`
* `validates_format_of`
* `validates_inclusion_of`
* `validates_length_of`
* `validates_presence_of`
* `validates_uniqueness_of`


!SLIDE bullets
# And most options

* `:message`
* `:on`
* `:allow_blank`
* `:minimum`, `:maximum`, `:is`, `:within`
* and more


!SLIDE bullets
# JavaScript client

* Not tied to Rails, jQuery etc.
* Easy-to-use DSL
* Handles DOM events and data logic
* Provides hooks for GUI code
* Extensible with new validators

