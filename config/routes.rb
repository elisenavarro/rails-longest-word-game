Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new'
  # get url/new got to the games controller for the 'new' action
  # which is linked to the view 'new.html.erb'
  post 'score', to: 'games#score'
  # 'posts' the form to controller action /score
end

# NOTES
# always code one route per controller action
# in this case, 'new' is considered the home page
# in this case, 'games' is the controller
# after url '/' add the controller action ie '/new' OR '/score'
# controller communicates with the route and to the view (route>controller>view)
