Rails.application.routes.draw do

  get 'admins/index'

  #비로그인 시 root
  root 'home#index'

  #신고
  resources :reports

  #로그인 시 메인
    get '/main' => 'evaluations#main'
    get '/info' => 'evaluations#info'

  #회원가입, 로그인
  get   '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#create'
  get   'sessions/new'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  get   '/logout',  to: 'sessions#destroy'

  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]

  #인증 이메일 안내 수정중
  get '/not_activated' => 'account_activations#not_activated'
  get '/activate/:token' => 'account_activations#activate'

  #인증 이메일 재전송
  get '/retry_activation' => 'account_activations#retry_activation' #안내 폼
  post '/retry_activation' => 'account_activations#process_activation' #실제 전송 프로세스

  #사용자 정보 수정
  get 'edit', to: 'users#edit'

  #이메일, 닉네임 유무 체크 (jQuery)
  post '/check_nickname' => 'users#check_nickname'
  post '/check_email' => 'users#check_email'

  #강의 리스트(검색결과)
  resources :courses
  #검색결과필터
  post '/courses/:id', to: 'courses#show', as: 'show'
  get  '/recent_evaluations', to: 'evaluations#recent'

  #Wiki
  post 'send_wiki' => "wikis#send_wiki"
  get  'wiki/:id/history' => "wikis#history"
  get  'wiki/:id/show/:revision' => "wikis#show"
  get  'wiki/:id/rollback/:revision' => "wikis#rollback"
  get  'wiki/:id/diff/:rev_1/:rev_2' => "wikis#diff"

  #강의평가 및 강의평가에 대한 댓글
  resources :evaluations do
    resources :comments, only: [:create]
  end

  #댓글 수정 및 삭제
  resources :comments, only: [:destroy]

  #마이페이지 - 열람권한 on/off, 작성한 강평리스트, 작성한 댓글리스트, 회원정보 수정 링크
  get 'mypage' => 'mypages#index'
  get 'info' => 'mypages#info'

  #cancancan
  post 'roles/evaluator'
  post 'roles/wikier'
  post 'roles/lack'

  #favoites
  post 'users/favorites_add'
  post 'users/favorites_delete'

  #is_like
  post 'users/is_like_create'
  post 'users/is_like_update'
  post 'users/is_like_delete'

  #cheat
  # get 'roles/charge'
end
