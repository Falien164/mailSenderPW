require 'swagger_helper'

RSpec.describe 'email_campaigns', type: :request do

  path '/email_campaigns' do
    get('list email_campaigns') do
      tags 'Email Campaigns'
      produces 'application/json'
      security [Bearer: []]

      response '200', 'successful' do
        run_test!
      end
    end

    post('create email_campaign') do
      tags 'Email Campaigns'
      consumes 'application/json'
      security [Bearer: []]
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email_campaign: {
            type: :object,
            properties: {
              title: { type: :string, example: 'Welcome campaign' },
              description: { type: :string, example: 'Campaiagn to welcome customers' },
              subject: { type: :string, example: 'Welcome' },
              body: { type: :string, example: 'Hello {{var:name}}, {{var:surname}}. We would like to welcome you!' }
            },
            required: [ 'title', 'description', 'subject', 'body' ]
          }
        }
      }

      response '201', 'created' do
        let(:email_campaign) { { title: 'Title', description: 'Description', subject: 'Subject', body: 'Body' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:email_campaign) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/email_campaigns/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:id) { EmailCampaign.create(title: 'Title', description: 'Description', subject: 'Subject', body: 'Body').id }

    get('show email_campaign') do
      tags 'Email Campaigns'
      consumes 'application/json'
      security [Bearer: []]

      response '200', 'successful fetch' do
        run_test!
      end
    end

    patch('update email_campaign') do
      tags 'Email Campaigns'
      consumes 'application/json'
      security [Bearer: []]
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email_campaign: {
            type: :object,
            properties: {
              title: { type: :string, example: 'New title' },
              description: { type: :string, example: 'New description' },
              subject: { type: :string, example: 'New subject' },
              body: { type: :string, example: 'New body' }
            },
            required: []
          }
        }
      }

      response '200', 'successful update' do
        let(:email_campaign) { { title: 'New title' } }
        run_test!
      end
    end

    put('update email_campaign') do
      tags 'Email Campaigns'
      consumes 'application/json'
      security [Bearer: []]
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email_campaign: {
            type: :object,
            properties: {
              title: { type: :string, example: 'New title' },
              description: { type: :string, example: 'New description' },
              subject: { type: :string, example: 'New subject' },
              body: { type: :string, example: 'New body' }
            },
            required: []
          }
        }
      }

      response '200', 'successfuly update' do
        let(:email_campaign) { { title: 'New title' } }
        run_test!
      end
    end

    delete('delete email_campaign') do
      tags 'Email Campaigns'
      consumes 'application/json'
      security [Bearer: []]

      response '204', 'successfuly deleted' do
        run_test!
      end
    end
  end

  path '/email_campaigns/{id}/mails' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:id) { EmailCampaign.create(title: 'Title', description: 'Description', subject: 'Subject', body: 'Body').id }

    get('mails email_campaign') do
      tags 'Mails'
      consumes 'application/json'
      security [Bearer: []]

      response '200', 'successful' do
        run_test!
      end
    end
  end

  path '/email_campaigns/{id}/clients' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:id) { EmailCampaign.create(title: 'Title', description: 'Description', subject: 'Subject', body: 'Body').id }

    get('clients email_campaign') do
      tags 'Clients'
      consumes 'application/json'
      security [Bearer: []]

      response '200', 'successful' do
        run_test!
      end
    end
  end

  path '/email_campaigns/{id}/add_client' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:id) { EmailCampaign.create(title: 'Title', description: 'Description', subject: 'Subject', body: 'Body').id }

    post('add_client email_campaign') do
      tags 'Clients'
      consumes 'application/json'
      security [Bearer: []]
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          client: {
            type: :object,
            properties: {
              email: { type: :string, example: 'mateusz@example.com' },
              name: { type: :string, example: 'Mateusz' },
              surname: { type: :string, example: 'Jawor' }
            },
            required: [:email, :name, :surname]
          }
        }
      }

      response(201, 'successful') do
        let(:client) { { email: 'mateusz@example.com', name: 'Mati', surname: 'Jawr' } }
        run_test!
      end
    end
  end

  path '/email_campaigns/{id}/delete_client' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:id) { EmailCampaign.create(title: 'Title', description: 'Description', subject: 'Subject', body: 'Body').id }

    delete('delete_client email_campaign') do
      tags 'Clients'
      consumes 'application/json'
      security [Bearer: []]
      parameter name: :params, in: :body, required: true, schema: {
        type: :object,
        properties: {
          client: {
            type: :object,
            properties: {
              id: { type: :string, example: '1c9fd481-d284-44c0-9534-b7443187eb82' }
            },
            required: [:id]
          }
        }
      }

      response(204, 'successful') do
        run_test!
      end
    end
  end

  path '/email_campaigns/{id}/send_mails' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    let(:id) { EmailCampaign.create(title: 'Title', description: 'Description', subject: 'Subject', body: 'Body').id }

    post('send_mails email_campaign') do
      tags 'Mails'
      consumes 'application/json'
      security [Bearer: []]

      response(200, 'successful') do
        run_test!
      end
    end
  end
end
