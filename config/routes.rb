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
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  #인증 이메일 안내 수정중
  get '/signup/send_authMail' => 'account_activations#authMail'

  #인증 이메일 재전송
  get '/signup/resend_authMail' => 'account_activations#re_authMail' #안내 폼
  post '/signup/resend_authMail' => 'account_activations#resend_authMail' #실제 전송 프로세스

  #사용자 정보 수정
  get 'edit', to: 'users#edit'

  #이메일, 닉네임 유무 체크 (jQuery)
  post '/check-nickname' => 'users#check_nickname'
  post '/check-email' => 'users#check_email'

  #강의 리스트(검색결과)
  resources :courses
  #검색결과필터
  post '/courses/:id', to: 'courses#show', as: 'show'

  #강의평가 및 강의평가에 대한 댓글
  resources :evaluations do
    resources :comments, only: [:create]
  end

  resources :likes, only: [:create, :update]

  #댓글 수정 및 삭제
  resources :comments, only: [:destroy]


  #마이페이지 - 열람권한 on/off, 작성한 강평리스트, 작성한 댓글리스트, 회원정보 수정 링크
  get 'mypage' => 'mypages#index'

  #cancancan
  post 'roles/evaluator'
  post 'roles/wikier'
  post 'roles/lack'

  #favoites
  post 'users/favorites_add'
  post 'users/favorites_delete'

  #cancancan 테스트용
  post 'roles/remove'
  post 'roles/reset'
  post 'roles/charge'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
