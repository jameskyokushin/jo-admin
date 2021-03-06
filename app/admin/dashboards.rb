ActiveAdmin::Dashboards.build do
  
   section "Job-Order Statistics" do
    div :class => "attributes_table" do
      table do
        tr do
          th "OVER ALL PENDING"
          td (JobOrder.where(:status => JobOrder::STATUS_PENDING).count), :style => "font-weight: bold;"
        end
   
        tr do
          th "COMPLETED"
          td (JobOrder.where(:status => JobOrder::STATUS_COMPLETED).count), :style => "font-weight: bold;"
        end

        tr do
          th "INSTALLATION"
          td (JobOrder.where(:category => JobOrder::CATEGORY_INSTALLATION).count), :style => "font-weight: bold;"
        end
      
         tr do
          th "SERVICES"
          td (JobOrder.where(:category => JobOrder::CATEGORY_SERVICE).count), :style => "font-weight: bold;"
        end
   
      end
    end
  end
   section "Latest Service/Installation" do
    table_for JobOrder.order('created_at desc').limit(5).all do |t|
      t.column("Status") { |joborder| status_tag joborder.status, joborder.status_tag }
      t.column("Company") { |joborder|joborder.company_name }
      t.column("System") { |joborder| joborder.system }
      t.column("Prepared by") { |joborder| joborder.prepared_by }
    end
  end
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
