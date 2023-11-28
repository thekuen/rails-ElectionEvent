class CandidatesController < ApplicationController
  before_action :find_candidate, only: [ :show, :edit, :update, :destroy]

  def vote
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.increment(:votes)
    @candidate.save
    redirect_to candidates_path, notice: "完成投票!"
  end


  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to candidates_path

    else
      render :new
    end

  end

  def edit
    @candidate = Candidate.find_by(id: params[:id])
  end

  def update
    @candidate = Candidate.find_by(id: params[:id])

    if @candidate.update(candidate_params)

      redirect_to candidates_path, notice: "資料更新成功"

    else
      render :edit
    end
  end

  def destroy
    @candidate = Candidate.find_by(id: params[:id ])
    @candidate.destroy if @candidate
    redirect_to candidates_path, notice: "資料已經刪除"
  end





  private

  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end

  def find_candidate
    @candidate = Candidate.find(params[:id])
  end




end
