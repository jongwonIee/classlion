Rails.application.routes.draw do



  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  #메인
  get 'home/index'

  #회원가입
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  #강의 리스트
  get 'courses/index'
  get 'courses/list'

  #강의평가 작성
  get 'evaluations/index'
  get 'evaluations/create'

  #강의평가의 댓글
  get 'comments/index'

  #마이페이지
  get 'mypages/index'

  # get ':controller(/:action(/:id))'
  # post ':controller(/:action(/:id))'
end
