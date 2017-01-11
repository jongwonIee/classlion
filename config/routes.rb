Rails.application.routes.draw do
  #비로그인 시 root
  root 'home#index'

  #메인
  get 'home/index'

  #회원가입, 로그인
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  #이메일, 닉네임 유무 체크 (jQuery)
  post '/check-user' => "users#check_user"

  #강의 리스트(검색결과)
  get 'courses/index'
  #강의 세부정보 - 강의평가 모음
  get 'courses/show'
  get 'courses/show/:id' => 'courses#show'

  resources :evaluations do
    resources :comments
  end
  get '/main' => 'evaluations#main'
  get '/info' => 'evaluations#info'

  resources :comments

  #마이페이지 - 열람권한 on/off, 작성한 강평리스트, 작성한 댓글리스트, 회원정보 수정 링크
  get 'mypage' => 'mypages#index'

  post 'roles/evaluator'
  post 'roles/wikier'
  post 'roles/lack'
  #테스트용
  post 'roles/remove'
  post 'roles/reset'
  post 'roles/charge'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
