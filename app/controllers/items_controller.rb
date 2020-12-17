class ItemsController < ApplicationController
  respond_to? :html, :js

  def create
    @item = Item.new(item_params)

    if !@item.save
      format.html { render 'topics/new' }
    end

  end

  def add_success
    @item = Item.find(params[:id])
    # @item.success += 1
    respond_to do |format|
      if @item.update(success: @item.success + 1)
        @random_item = @item.topic.random_item
        @action = "Add success"
        format.html
        format.js { render 'new_item', layout: false }
      else
        format.html
        format.js { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_mistake
    @item = Item.find(params[:id])
    # @item.mistakes += 1
    respond_to do |format|
      if @item.update(mistakes: @item.mistakes + 1)
        @random_item = @item.topic.random_item
        @action = "Add mistake"
        format.html
        format.js { render 'new_item', layout: false }
      else
        format.html
        format.js { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end





  private

  def item_params
    params.require(:items).permit(:key, :value, :topic_id)
  end
end
