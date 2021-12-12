class EmailCampaignsController < ApplicationController
  before_action :set_email_campaign, only: %i[show update destroy add_client clients mails delete_client send_mails]

  def index
    @email_campaigns = @current_user.email_campaigns.all
    render json: @email_campaigns.to_json(except: :user_id)
  end

  def show
    render json: @email_campaign.to_json(except: :user_id)
  end

  def create
    @email_campaign = @current_user.email_campaigns.new(email_campaign_params)

    if @email_campaign.save
      render json: @email_campaign.to_json(except: :user_id)
    else
      render json: @email_campaign.errors, status: :unprocessable_entity
    end
  end

  def update
    if @email_campaign.update(email_campaign_params)
      render json: @email_campaign.to_json(except: :user_id)
    else
      render json: @email_campaign.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @email_campaign.destroy
    head :no_content
  end

  def mails
    render json: @email_campaign.mail_histories.to_json
  end

  def clients
    render json: @email_campaign.clients.to_json
  end

  def add_client
    @client = @email_campaign.clients.new(client_params)

    if @client.save
      render json: @client.to_json
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def delete_client
    @email_campaign.clients.find(client_params[:id]).destroy
    head :no_content
  end

  def send_mails
    @email_campaign.send_to_new_clients
    head :ok
  end

  private
    def set_email_campaign
      @email_campaign = @current_user.email_campaigns.find_by(id: params[:id])
      if @email_campaign.nil?
        render json: { error: 'not found' }.to_json, status: 404 and return
      end
    end

    def email_campaign_params
      params.require(:email_campaign)
            .permit(:title, :description, :body, :subject)
    end

    def client_params
      params.require(:client).permit(:email, :name, :surname, :id)
    end
end
