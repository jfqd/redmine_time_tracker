RedmineApp::Application.routes.draw do
  match 'time_trackers/stop' => 'time_trackers#stop'
  match 'time_trackers/start' => 'time_trackers#start'
  match 'time_trackers/suspend' => 'time_trackers#suspend'
  match 'time_trackers/resume' => 'time_trackers#resume'
  match 'time_trackers/render_menu' => 'time_trackers#render_menu'
  match 'time_trackers/add_status_transition' => 'time_trackers#add_status_transition'
  match 'time_trackers/delete_status_transition' => 'time_trackers#delete_status_transition'
  match 'time_trackers/show_report' => 'time_trackers#show_report'
  match 'time_trackers/delete' => 'time_trackers#delete'
  match 'time_trackers' => 'time_trackers#index'
end
