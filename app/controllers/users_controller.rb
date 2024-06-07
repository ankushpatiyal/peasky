class UsersController < ApplicationController
  def index
    users = User.paginate(page: params[:page], per_page: 10)
    user_data = users.map{ |a| a.attributes.merge({'url' => user_url(a.id)}) }

    variables = {
      'users' => user_data,
      'paginate' => {
        'current_page' => users.current_page,
        'total_pages' => users.total_pages,
        'previous_page' => users.previous_page,
        'next_page' => users.next_page,
        'total_entries' => users.total_entries
      },
      'form_authenticity_token' => form_authenticity_token,
      'stylesheet_tag' => ActionController::Base.helpers.stylesheet_link_tag('application'),
      'headers' => render_to_string('header')
    }

    template = File.read(Rails.root.join('app', 'views', 'users', 'index.liquid'))
    rendered_template = Liquid::Template.parse(template).render(variables)

    render html: rendered_template.html_safe
  end

  def destroy
    @user = User.where(id: params[:id]).last.destroy
    redirect_to root_url(page: params[:page])
  end
end