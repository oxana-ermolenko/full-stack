class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /journals
  def index
    @journals = Journal.all

    render json: @journals
  end

  # GET /journals/1
  def show
    render json: @journal
  end

  

  # POST /journals
  def create
    @journal = Journal.new(journal_params)
    @journal.user = current_user
    if @journal.save
      render json: @journal, status: :created, location: @journal
    else
      render json: @journal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /journals/1
  def update
    if @journal.update(journal_params)
      render json: @journal
    else
      render json: @journal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /journals/1
  def destroy
    @journal.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def journal_params
      params.require(:journal).permit(:title, :body, :user_id)
    end
end
