require 'csv'

class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.where(user: current_user)
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    redirect_to root_path if @topic.user != current_user
    @random_item = @topic.random_item
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user

    csv_file = params[:topic][:csv_file].tempfile.to_path.to_s

    elements = []

    respond_to do |format|
      if @topic.save
        csv_options = { headers: true, header_converters: :symbol }
        CSV.foreach(csv_file, csv_options) do |row|
          row[:topic_id] = @topic.id
          elements << row.to_h
        end
        Item.import(elements)

        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def stats
    @topic = Topic.find(params[:topic_id])
    redirect_to root_path if @topic.user != current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:name, :key_term, :value_term, :csv_file)
    end
end
