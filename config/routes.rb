MetricIo::Application.routes.draw do
  resources :sites do
    resources :measurements
  end
end
