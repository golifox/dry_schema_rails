### DrySchemaRails: Simplify Your Schema Management in Rails

DrySchemaRails is a lightweight gem that leverages `dry-schema` for defining schemas in a DRY and consistent manner across your Rails application. It encapsulates common schema definition functionalities, promoting a clean and easy-to-follow schema definition practice.

#### Key Features
- **Concise Schema Definitions**: Write compact and clear schema definitions using block syntax.
- **Reusable Schemas**: Create and reuse schema definitions across different parts of your application.
- **Extendable**: Easily extend and customize your schema definitions as per your requirements.

#### Installation

Add DrySchemaRails to your Gemfile and bundle.

```ruby
gem 'dry_schema_rails'
```

Run
```bash
bundle install
```

#### Quick Usage Guide

1. **Define Schema:**

   Define your schema classes with necessary validation rules in a block passed to `schema`.

   ```ruby
   class UserSchema < DrySchemaRails::ApplicationSchema
     schema do
       required(:username).filled(:string)
       required(:email).filled(:string, format?: /@/)
       required(:age).filled(:integer, gt?: 18)
     end
   end
   ```

2. **Use Schema:**

   Validate and sanitize parameters using defined schemas.

   ```ruby
   user_params = { username: "John", email: "john@example.com", age: 25 }
   result = UserSchema.call(user_params)
   
   puts result.success?   # => true
   puts result.errors     # => {}
   ```

#### In-Depth Usage

##### Custom Validators
```ruby
module User
  class CreateValidator < DrySchemaRails::Base
    params User::CreateSchema.params
  end
end
```

##### In Controllers
```ruby
class UsersController < ApiController
  ...
  schema(:create, &User::CreateSchema.schema) 
  
  # This checks maybe in base controller for reusability
  if safe_params&.failure?
    render json: { errors: safe_params.errors }, status: :unprocessable_entity
  end
  
  def create
    @user = User.create!(safe_params.output)
    render json: @user, status: :created
  end
  ...
end
```

### Example Application: DrySchemaRailsDemo

#### Idea

Create a Rails application `DrySchemaRailsDemo` demonstrating the usage of `DrySchemaRails` in various common Rails use-cases: model validation, parameter validation in controllers, form object validation, etc.

#### Key Features:

- **User Management:** Simple CRUD for managing users with validations using defined schemas.
- **API Endpoint:** Demonstrate parameter validation for API endpoints.
- **Form Object:** Use schemas to validate form objects.

#### Implementation

1. **Model and Schema:**

   Define `User` model and `UserSchema` for validating user attributes.

   ```ruby
   class User < ApplicationRecord
     # your model code
   end
   
   class UserSchema < DrySchemaRails::Base
     schema do
       required(:username).filled(:string)
       # additional validations...
     end
   end
   ```

2. **Controller Validation:**

   Implement validations in controllers and API endpoints using schema.

   ```ruby
   class UsersController < ApplicationController
     def create
       validation = UserSchema.call(params.permit!.to_h)
       if validation.success?
         # handle success...
       else
         # handle failure...
       end
     end
   end
   ```

3. **Form Object:**

   Define form objects validating data using schema before processing.

   ```ruby
   class RegistrationForm
     def initialize(params)
       @params = params
     end
     
     def save
       validation = UserSchema.call(@params)
       if validation.success?
         User.create(validation.output)
       else
         # handle errors...
       end
     end
   end
   ```

#### Tests

Write tests for models, controllers, and form objects ensuring schema validations are applied and working as expected.

---

For more complex understanding you might adjust specifics to cater to the unique needs and standards of your app or team. For further details on `dry-schema`, visit [Dry Schema](https://dry-rb.org/gems/dry-schema).