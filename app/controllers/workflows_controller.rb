require './app/presenters/workflow/show'

class WorkflowsController < ApplicationController
  include InitialState

  def create
    @workflow = Workflow.new(workflow_params)
    if @workflow.save
      flash[:notice] = "The workflow was created."
      redirect_to("/admin")
    else
      flash[:error] = @workflow.errors.full_messages.join('; ')
      redirect_to :back
    end
  end

  def show
    @presenter = Presenter::WorkflowPresenter::Show.new(workflow)
  end

  def update
    workflow.assign_attributes(workflow_params)
    if workflow.save
      flash[:notice] = "The workflow was updated."
      redirect_to("/admin")
    else
      flash[:error] = workflow.errors.full_messages.join('; ')
      redirect_to :back
    end
  end

  private

  def workflow_params
    {
      name:               params[:name],
      has_comment:        params[:hasComment] || false,
      reportable:         params[:reportable] || false,
      qc_flow:            params[:qc_flow] || false,
      cherrypick_flow:    params[:cherrypick_flow] || false,
      active:             params[:active] || false,
      initial_state_name: initial_state_name,
      turn_around_days:   turn_around_days
    }
  end

  def workflow
    @workflow ||= Workflow.find_by_id(params[:id])
  end

  def turn_around_days
    params[:turn_around_days].to_i if params[:turn_around_days].present?
  end

  def initial_state_name
    params[:initial_state_name] || initial_state(params[:qc_flow], params[:cherrypick_flow])
  end
end
