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
    @item.success += 1
    @random_item = @item.topic.random_item
    respond_to do |format|
      # if @item.save
      #   format.js {render layout: false}
      #   format.html {render head: 200, content_type: "text/html"}
      # end

      if @item.save
        format.html
        format.js { render layout: false }
      else
        format.html
        format.js { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_mistake
    @item = Item.find(params[:id])
    @item.mistakes += 1
    @item.save
  end





  private

  def item_params
    params.require(:items).permit(:key, :value, :topic_id)
  end
end
