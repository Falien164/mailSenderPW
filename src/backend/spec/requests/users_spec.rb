require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/sign_up' do
    post('sign up user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Jan Kowalski' },
              email: { type: :string, example: 'jan@gmail.com' },
              password: { type: :string, example: '123456' },
              password_confirmation: { type: :string, example: '123456' }
            },
            required: [ 'email', 'password', 'password_confirmation' ]
          }
        }
      }

      response '201', 'created' do
        run_test!
      end
    end
  end

  path '/sign_in' do
    post('sign in user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'jan@gmail.com' },
              password: { type: :string, example: '123456' },
            },
            required: [ 'email', 'password' ]
          }
        }
      }

      response '200', 'created' do
        run_test!
      end
    end
  end
end
