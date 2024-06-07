class DailyRecordsController < ApplicationController
  def index
    daily_records =  DailyRecord.paginate(page: params[:page], per_page: 10)

    daily_record_data = daily_records.map{ |a| a.attributes }

    variables = {
      'daily_records' => daily_record_data,
      'paginate' => {
        'current_page' => daily_records.current_page,
        'total_pages' => daily_records.total_pages,
        'previous_page' => daily_records.previous_page,
        'next_page' => daily_records.next_page,
        'total_entries' => daily_records.total_entries
      },
      'form_authenticity_token' => form_authenticity_token,
      'stylesheet_tag' => ActionController::Base.helpers.stylesheet_link_tag('application'),
      'headers' => render_to_string('header')
    }

    template = File.read(Rails.root.join('app', 'views', 'daily_records', 'index.liquid'))
    rendered_template = Liquid::Template.parse(template).render(variables)

    render html: rendered_template.html_safe
  end
end