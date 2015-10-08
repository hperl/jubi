include Features

ButWebsite::Application.routes.draw do
  scope(path_names: { new: 'neu', edit: 'bearbeiten' }) do
    with_feature :login do
      devise_for :users, path: 'benuter', path_names: {
        sign_in:      'anmelden',
        sign_up:      'registrieren',
        sign_out:     'abmelden',
        password:     'passwort',
        confirmation: 'bestaetigung',
        registration: 'registrierung'
      }
      resource  :profile          , only: %w(show)                  , path: 'profil'
      resource  :ws_results       , only: %w(show)                  , path: 'workshop-ergebnisse'

      with_feature :music_wishes do
        resource  :music_wishes   , only: %w(show edit update)      , path: 'musikwünsche'
      end

      with_feature :photos do
        resources :photos, only: %w(index), path: 'fotos' do
          collection do
            get 'download'
          end
        end
      end

      registration_methods = %w(edit update destroy)
      unless enabled? :no_more_registrations
        registration_methods << 'new'
        registration_methods << 'create'
      end
      resources :but_registrations, only: registration_methods, path: 'but-anmeldung' do
        with_feature :workshop_choices do
          resources :workshop_choices, only: %w(create), path: 'workshopwahl'
          resources :timeslots, only: [] do
            patch 'help', path: 'helfen'
          end
        end
      end
      with_feature :workshop_choices do
        resource :but_plan, only: %w(show), path: 'plane-dein-but'
      end
      resources :payments,          only: %w(index)                 , path: 'zahlungen'

      resources :groups, path: 'gruppen' do
        resources :invitations, path: 'einladung', only: %w(show create destroy)

        member do
          delete 'leave',   path: 'austreten'
        end
      end
    end

    with_feature :workshops do
      resources :workshops do
        member do
          patch 'remember', path: 'merken'
          patch 'toggle_visibility', path: 'freischalten'
        end
      end
    end

    scope module: :but_board do
      resource :but_board, controller: 'but_board', path: 'but-board', only: :show do
        get 'users'    , path: 'personen'
        get 'helpers'  , path: 'helfer'
        get 'download' , path: 'excel-liste'
        get 'workshops' , path: 'workshops'
        resource :sudo, controller: 'sudo', only: 'show', path: 'sudo' do
          post 'switch'
        end
        resources :payments, only: %w(new create index), path: 'zahlungen'
        resources :workshops, only: %w(index create destroy), path: 'workshop-einteilung'
        with_feature :algorithm do
          resource :algorithm, only: :show, path: 'algorithmus' do
            post 'rerun'
          end
        end
      end
    end
  end

  get '*id', to: 'pages#show', as: :page, format: false
  #root to: 'profiles#show'
  root       to: 'pages#show', id: 'index'
end
