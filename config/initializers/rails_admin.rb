RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.admin?
  end

  config.model 'Attendee' do
    list do
      filters [:event, :user, :email, :created_at]
      field :event do
        label "Event"
        formatted_value do
          bindings[:view].tag(:a, { :href => "/admin/event/#{bindings[:object].event.id}" }) << bindings[:object].event.title
        end
        filterable true
      end
      field :user do
        label "Attendee Full Name"
        formatted_value do
          bindings[:object].user.fullname
        end
        pretty_value do
          bindings[:view].tag(:a, { :href => "/admin/user/#{bindings[:object].user.id}" }) << bindings[:object].user.fullname
        end
        filterable true
      end

      field :email do
        label "Email"
        formatted_value do
          bindings[:object].user.email
        end
        filterable true
      end
      field :created_at do
        label "Registered On"
      end
    end
    export do
      field :event_id do
        export_value do
          bindings[:object].event.title
        end
      end
      field :user_full_name do
        export_value do
          bindings[:object].user.fullname
        end
      end
      field :user_first_name do
        export_value do
          bindings[:object].user.first_name
        end
      end
      field :user_last_name do
        export_value do
          bindings[:object].user.last_name
        end
      end
      field :email do
        export_value do
          bindings[:object].user.email
        end
      end
      field :created_at
    end
    
  end






  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
