module ApplicationHelper
  def time_tracker_for(user)
    TimeTracker.where(:user_id => user.id).first
  end

  def status_from_id(status_id)
    IssueStatus.where(:id => status_id).first
  end

  def statuses_list()
    IssueStatus.all
  end

  def to_status_options(statuses)
      options_from_collection_for_select(statuses, 'id', 'name')
  end

  def new_transition_from_options(transitions)
    statuses = []
    for status in statuses_list()
      if !transitions.has_key?(status.id.to_s)
        statuses << status
      end
    end
    to_status_options(statuses)
  end

  def new_transition_to_options()
      to_status_options(statuses_list())
  end

  def global_allowed_to?(user, action)
    return false if user.nil?

    projects = Project.find(:all)
    for p in projects
      if user.allowed_to?(action, p)
        return true
      end
    end

    return false
  end
  
  # http://stackoverflow.com/questions/3332474/how-to-make-ajax-calls-with-rails-3-using-remote-function
  def remote_function(options)
    ("jQuery.ajax({url: '#{ url_for(options[:url]) }', type: '#{ options[:method] || 'GET' }', " +
    "data: #{ options[:with] ? options[:with] + '&amp;' : '' } + " +
    "'authenticity_token=' + encodeURIComponent('#{ form_authenticity_token }')" +
    (options[:data_type] ? ", dataType: '" + options[:data_type] + "'" : "") +
    (options[:success] ? ", success: function(data) {" + options[:success] + "}" : "") +
    (options[:before] ? ", beforeSend: function(data) {" + options[:before] + "}" : "") + "});").html_safe
  end
  
  def link_to_remote(name, options = {}, html_options = nil)
    link_to_function(name, remote_function(options), html_options || options.delete(:html))
  end
  
  def link_to_function(name, *args, &block)
    html_options = args.extract_options!.symbolize_keys
  
    function = block_given? ? update_page(&block) : args[0] || ''
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'
  
    content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
  end
  
end
