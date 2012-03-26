require 'routing-filter'

N2::Application.routes.draw do
  filter :locale # Provided by routing-filter

  match '/' => "home#index", :as => :root

  match '/auth/:provider/callback' => "sessions#create"

  resources :oauth_consumers do
    member do
      get :callback
    end
  end

  resources :resource_sections do
    resources :resources
    member do
      get :like
      post :like
    end
  end

  match '/overlays/tweet' => 'overlays#tweet', :as => :overlay_tweet

  # TODO RAILS3
  #match 'locale' => '#index', :as => :filter
  #match 'iframe' => '#index', :as => :filter

  resource :oauth
  match '/oauth/create' => 'oauth#create', :as => :oauth_callback

  match '/auth/:provider/callback' => 'sessions#create', :as => :auth_provider_callback

  match '/robots.txt' => 'home#robots', :as => :robots

  match '/test_design' => 'home#test_design', :as => :test_design
  match '/test_design.:format' => 'home#test_design', :as => :test_design

  match '/block.:format' => 'flags#block', :as => :toggle_blocked
  match '/feature.:format' => 'flags#feature', :as => :toggle_featured
  match '/like.:format' => 'votes#like', :as => :like_item
  match '/dislike.:format' => 'votes#dislike', :as => :dislike_item
  match '/logout.:format' => 'sessions#destroy', :as => :logout
  match '/login.:format' => 'sessions#new', :as => :login
  match '/register.:format' => 'users#create', :as => :register
  match '/signup.:format' => 'users#new', :as => :signup
  match '/account_menu.:format' => 'users#account_menu', :as => :account_menu
  match '/faq.:format' => 'home#faq', :as => :faq
  match '/about.:format' => 'home#about', :as => :about
  match '/terms.:format' => 'home#terms', :as => :terms
  match '/test_widgets.:format' => 'home#test_widgets', :as => :test_widgets
  match '/contact_us.:format' => 'home#contact_us', :as => :contact_us
  match '/app_tab.:format' => 'home#app_tab', :as => :app_tab
  match '/external_page.:format' => 'home#external_page', :as => :external_page

  match '/newswires/feed/:feed_id.:format' => 'newswires#feed_index', :as => :feed_newswires
  match '/articles/page/:page.:format' => 'articles#index', :as => :paged_articles
  match '/articles/user/:user_id.:format' => 'articles#user_index', :as => :user_articles
  match '/shared_item' => 'votes#shared_item', :as => :shared_item
  match '/articles/page/:page.:format' => 'articles#index', :as => :paged_articles_with_format
  match '/classifieds/page/:page.:format' => 'classifieds#index', :as => :paged_classifieds
  match '/classifieds/page/:page.:format' => 'classifieds#index', :as => :paged_classifieds_with_format
  match '/events/page/:page.:format' => 'events#index', :as => :paged_events
  match '/newswires/feed/:feed_id/page/:page.:format' => 'newswires#feed_index', :as => :paged_feed_newswires
  match '/forums/:id/page/:page.:format' => 'forums#show', :as => :paged_forums
  match '/forums/:id/page/:page.:format' => 'forums#show', :as => :paged_forums_with_format
  match '/galleries/page/:page.:format' => 'galleries#index', :as => :paged_galleries
  match '/galleries/page/:page.:format' => 'galleries#index', :as => :paged_galleries_with_format
  match '/ideas/page/:page.:format' => 'ideas#index', :as => :paged_ideas
  match '/idea_boards/:id/page/:page.:format' => 'idea_boards#show', :as => :paged_idea_boards
  match '/idea_boards/:id/page/:page.:format' => 'idea_boards#show', :as => :paged_idea_boards_with_format
  match '/events/:id/my_events/page/:page.:format' => 'events#my_events', :as => :paged_my_events
  match '/questions/:id/my_questions/page/:page.:format' => 'questions#my_questions', :as => :paged_my_questions
  match '/resources/:id/my_resources/page/:page.:format' => 'resources#my_resources', :as => :paged_my_resources
  match '/newswires/page/:page.:format' => 'newswires#index', :as => :paged_newswires
  match '/prediction_groups/page/:page.:format' => 'prediction_groups#index', :as => :paged_prediction_groups
  match '/questions/page/:page.:format' => 'questions#index', :as => :paged_questions
  match '/resources/page/:page.:format' => 'resources#index', :as => :paged_resources
  match '/stories/page/:page.:format' => 'stories#index', :as => :paged_stories
  match '/stories/page/:page.:format' => 'stories#index', :as => :paged_stories_with_format
  match '/articles/user/:user_id/page/:page.:format' => 'articles#user_index', :as => :paged_user_articles
  match '/users/:id/page/:page.:format' => 'users#show', :as => :paged_users
  match '/users/:id/page/:page.:format' => 'users#show', :as => :paged_users_with_format


  match '/articles/tag/:tag.:format' => 'articles#tags', :as => :tagged_articles
  match '/articles/tag/:tag/page/:page.:format' => 'articles#tags', :as => :tagged_articles_with_page
  match '/classifieds/tag/:tag.:format' => 'classifieds#tags', :as => :tagged_classifieds
  match '/classifieds/tag/:tag/page/:page.:format' => 'classifieds#tags', :as => :tagged_classifieds_with_page
  match '/stories/tag/:tag.:format' => 'stories#tags', :as => :tagged_contents
  match '/stories/tag/:tag/page/:page.:format' => 'stories#tags', :as => :tagged_contents_with_page
  match '/events/tag/:tag.:format' => 'events#tags', :as => :tagged_events
  match '/events/tag/:tag/page/:page.:format' => 'events#tags', :as => :tagged_events_with_page
  match '/forums/:forum_id/tag/:tag.:format' => 'topics#tags', :as => :tagged_forum
  match '/forums/:forum_id/tag/:tag/page/:page.:format' => 'topics#tags', :as => :tagged_forum_with_page
  match '/galleries/tag/:tag.:format' => 'galleries#tags', :as => :tagged_galleries
  match '/galleries/tag/:tag/page/:page.:format' => 'galleries#tags', :as => :tagged_galleries_with_page
  match '/ideas/tag/:tag.:format' => 'ideas#tags', :as => :tagged_ideas
  match '/ideas/tag/:tag/page/:page.:format' => 'ideas#tags', :as => :tagged_ideas_with_page
  match '/prediction_groups/tag/:tag.:format' => 'prediction_groups#tags', :as => :tagged_prediction_groups
  match '/prediction_groups/tag/:tag/page/:page.:format' => 'prediction_groups#tags', :as => :tagged_prediction_groups_with_page
  match '/prediction_questions/tag/:tag.:format' => 'prediction_questions#tags', :as => :tagged_prediction_questions
  match '/prediction_questions/tag/:tag/page/:page.:format' => 'prediction_questions#tags', :as => :tagged_prediction_questions_with_page
  match '/questions/tag/:tag.:format' => 'questions#tags', :as => :tagged_questions
  match '/questions/tag/:tag/page/:page.:format' => 'questions#tags', :as => :tagged_questions_with_page
  match '/resources/tag/:tag.:format' => 'resources#tags', :as => :tagged_resources
  match '/resources/tag/:tag/page/:page.:format' => 'resources#tags', :as => :tagged_resources_with_page
  match '/stories/tag/:tag.:format' => 'stories#tags', :as => :tagged_stories
  match '/stories/tag/:tag/page/:page.:format' => 'stories#tags', :as => :tagged_stories_with_page

  match '/ideas/tag/:tag/page/:page.:format' => 'ideas#tags', :as => :idea_tag_with_page
  match '/ideas/tag/:tag.:format' => 'ideas#tags', :as => :idea_tag
  match '/resources/tag/:tag/page/:page.:format' => 'resources#tags', :as => :resource_tag_with_page
  match '/resources/tag/:tag.:format' => 'resources#tags', :as => :resource_tag
  match '/events/tag/:tag/page/:page.:format' => 'events#tags', :as => :event_tag_with_page
  match '/events/tag/:tag.:format' => 'events#tags', :as => :event_tag
  match '/prediction_groups/tag/:tag/page/:page.:format' => 'prediction_groups#tags', :as => :prediction_group_tag_with_page
  match '/prediction_groups/tag/:tag.:format' => 'prediction_groups#tags', :as => :prediction_group_tag
  match '/prediction_questions/tag/:tag/page/:page.:format' => 'prediction_questions#tags', :as => :prediction_question_tag_with_page
  match '/prediction_questions/tag/:tag.:format' => 'prediction_questions#tags', :as => :prediction_question_tag
  match '/users/top/:top.:format' => 'users#index', :as => :top_users

  match '/classifieds/:id/set_status/:status.:format' => 'classifieds#set_status', :as => :set_status_classified
  match '/classifieds/category/:category.:format' => 'classifieds#categories', :as => :categorized_classifieds
  match '/classifieds/category/:category/page/:page.:format' => 'classifieds#categories', :as => :categorized_classifieds_with_page
  
  match '/tags/suggest' => 'tags#suggest', :as => :tags_suggest

  resources :users do
    collection do
      get :link_user_accounts
      %w( feed invite current update_bio dont_ask_me_invite_friends dont_ask_me_for_email ).each do |action|
        get action
        post action
      end
    end
  end


  resources :view_objects do
    collection do
      get :test
    end
  end

  resources :widgets do
    collection do
      get :newswires
      get :questions
      get :forum_roll
      get :topics
      get :blog_roll
      get :blogger_profiles
      get :fan_applications
      get :add_bookmark
      get :user_articles
      get :articles
      get :stories
      get :activities
    end
  end

  resources :topics do
    resources :flags, :comments, :related_items
  end

  match '/cards/received/:card_id/from/:user_id.:format' => 'cards#received', :as => :received_cards

  resources :amazon_products do
    collection do
      get :search
      post :search
    end
  end

  resource :session

  resources :answers do
    member do
      get :like
      post :like
    end
    resources :answers
    resources :flags, :comments, :related_items
  end

  resources :articles do
    collection do
      get :drafts
    end
    resources :flags, :comments, :related_items
  end

  resources :cards do
    collection do
      get :my_received
      get :my_sent
    end
    member do
      get :post_sent
      post :post_sent
      get :get_card_form
      post :get_card_form
    end
    resources :flags, :comments, :related_items
  end

  resources :classifieds do
    collection do
      get :borrowed_items
      get :my_items
    end
    resources :flags, :comments, :related_items
  end

  resources :comments do
    member do
      get :like
      post :like
      get :dislike
      post :dislike
    end
    resources :flags
  end

  # RAILS3 TODO
  resources :contents, :controller => :stories, :as => :stories
  match '/stories/parse_page' => 'stories#parse_page'
  match '/stories.:format' => 'stories#index'

  # adding this to fix the old story posting bookmarklet
  # which was broken by the new routes
  match '/stories/new' => 'stories#new'

  resources :contents do
    resources :flags, :comments, :related_items
  end


  resources :events do
    collection do
      get :import_facebook
      post :import_facebook
    end
    member do
      get :like
      post :like
      get :my_events
      post :my_events
    end
    resources :flags, :comments, :related_items
  end

  resources :forums do
    resources :topics
    resources :flags, :comments, :related_items
  end

  resources :galleries do
    member do
      get :add_gallery_item
      post :add_gallery_item
    end
    resources :comments, :flags, :related_items
  end

  resources :gallery_items, :format => false do
    resources :comments, :flags, :related_items
  end

  resources :go, :only => :show

  resource :home, :controller => "home" do
    collection do
      get :about
      get :openx_ads
      get :contact_us
      post :contact_us
      get :helios_ads
      get :app_tab
      post :app_tab
      get :helios_alt2_ads
      get :preview_widgets
      get :faq
      get :helios_alt3_ads
      get :default_ads
      get :terms
      get :helios_alt4_ads
      get :google_ads
    end
    member do
      get :render_widget
      post :render_widget
    end

  end

  resources :idea_boards do
    resources :ideas
    resources :flags, :comments, :related_items
  end

  resources :ideas do
    member do
      get :like
      post :like
      get :my_ideas
      post :my_ideas
    end
    resources :flags, :comments, :related_items
  end

  resources :newswires do

    member do
      get :quick_post
      post :quick_post
    end
    resources :flags, :comments, :related_items
  end

  resources :prediction_groups do
    collection do
      get :play
      post :play
    end
    member do
      get :like
      post :like
    end
    resources :flags, :comments, :related_items
  end

  resources :prediction_questions do
    member do
      get :like
      post :like
    end
    resources :flags, :comments, :related_items
  end

  resources :predictions do
    collection do
      get :my_predictions
      post :my_predictions
      get :scores
      post :scores
    end
    resources :flags, :comments, :related_items
  end

  resources :resources do
    member do
      get :like
      post :like
      get :my_resources
      post :my_resources
    end
    resources :flags, :comments, :related_items
  end

  resources :questions do
    member do
      get :like
      post :like
      post :create_answer
      get :my_questions
      post :my_questions
    end
    resources :flags, :comments, :related_items
  end

  # This will redirect /images/something.jpg to /assets/something.jpg
  # Should be removed once all the code uses the Rails asset pipeline
  match "/images/*path.:format" => redirect { |params| "/assets/#{ params[:path] }.#{ params[:format]}" }
end
