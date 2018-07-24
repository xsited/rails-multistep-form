class TemplatesController < ApplicationController
  before_action :load_template

  def index
    @templates = Template.all
  end

  def show
  end

  def new
    @wizard = ModelWizard.new(Template, session, params).start
    @template = @wizard.object
  end

  def edit
    @wizard = ModelWizard.new(@template, session, params).start
  end

  def create
    @wizard = ModelWizard.new(Template, session, params, template_params).continue
    @template = @wizard.object
    if @wizard.save
      redirect_to @template, notice: "Template created!"
    else
      render :new
    end
  end

  def update
    @wizard = ModelWizard.new(@template, session, params, template_params).continue
    if @wizard.save
      redirect_to @template, notice: 'Template updated.'
    else
      render :edit
    end
  end

  def destroy
    @template.destroy
    redirect_to templates_url
  end

private

  def load_template
    @template = Template.find_by(id: params[:id])
  end

  def template_params
    return params unless params[:template]

    params.require(:template).permit(:current_step,
      :name,
      :description,
      :regions,
      :deployments,
      :"available_at(1i)",
      :"available_at(2i)",
      :"available_at(3i)",
      :"available_at(4i)",
      :"available_at(5i)",
      :hosts,
      :hosts_attributes => [:id, :name]
    )
  end

end
