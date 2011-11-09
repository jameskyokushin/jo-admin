ActiveAdmin.register JobOrder do
filter :company_name
filter :contact_person
filter :technical1
 action_item :only => :show do
    link_to "COMPLETED", send_joborder_admin_job_order_path(resource)
  end
  
  member_action :send_joborder do
    @job_oder = JobOrder.find(params[:id])
    @job_oder.status = JobOrder::STATUS_COMPLETED
    @job_oder.save
    
    redirect_to admin_job_order_path(@job_oder), :notice => "Job Order Completed"
  end
  
  scope :all, :default => true

  scope :PENDING do |joborders|
    joborders.where(:status => JobOrder::STATUS_PENDING)
  end

  scope :COMPLETED do |joborders|
    joborders.where(:status => JobOrder::STATUS_COMPLETED)
  end

  scope :INSTALLATION do |joborders|
    joborders.where(:category => JobOrder::CATEGORY_INSTALLATION)
  end
  
  scope :SERVICE do |joborders|
    joborders.where(:category => JobOrder::CATEGORY_SERVICE)
  end

  form do |f|
  
    f.inputs "Company Details" do
      f.input :company_name
      f.input :contact_person 
      f.input :contact_number
      f.input :address
    end
    f.inputs "Job Order" do
      f.input :category, :collection => JobOrder.category_collection, :as => :radio
      
      f.input :system,:collection => [["- Select -","  "],["Automatic Gates"," Automatic Gates"],["Metal Detectors","Metal Detectors"],["CCTV","CCTV"],["Access Control","Access Control"],["Intrusion","Intrusion"],["Fire Alarm","Fire Alarm"],["Light Automation","Light Automation"],["Automated Window Treatment","Automated Window Treatment"],["Home Run","Home Run"],["Installation Accessories","Installation Accessories"],["Cable","Cable"],["Radio","Radio"],["Voip","Voip"],["Network Cabinet","Network Cabinet"],["Public Address System","Public Address System"],["Telecom","Telecom"],["Id Printer","Id Printer"],["Pc Pheripherals","Pc Pheripherals"],["Card","Card"],["Networking","Networking"],["Door Automation","Door Automation"],["Parking System","Parking System"],["Turnstile","Turnstile"],["Others","Others"]], :include_blank => false
     f.input :technical1, :label => "Team Leader", :hint => "Please your Name (example:JUAN DELA CRUZ)"
     f.input :technical2, :label => "Technical", :hint => "Please your Name (example:JUAN DELA CRUZ)"
     f.input :todo, :input_html => { :rows => 4 }, :label => "Things To do"
     f.input :work_done, :input_html => { :rows => 4 }, :label => "Works Done"
     f.input :remarks, :input_html => { :rows => 4,  }, :label => "Remarks"
     f.input :status, :collection => JobOrder.status_collection, :hint => "YOU NEED TO PICK ONE STATUS", :include_blank => false, :wrapper_html => { :style => "display:none;" }

    end
    f.buttons
  end
  show :title => :category do
    panel "Company Information" do
      attributes_table_for job_order do
      row("Company Name") { job_order.company_name }
      row("Contact Person") { job_order.contact_person }
      row("Address") { job_order.address }
      row("Contact Number") { job_order.contact_number }
      row("System") { job_order.system }
      row("Team Leader") { job_order.technical1 }
      row("Installer") { job_order.technical2 }
    panel "Remarks" do
      attributes_table_for job_order do
        row("To Do ") { simple_format job_order.todo }
        row("Work Done") { simple_format job_order.work_done }
        row("Remarks") { simple_format job_order.remarks }
      end
    end
      end
    end
  end
  index do
    column :status do |joborder|
     status_tag joborder.status, joborder.status_tag
   end
    column :category do |joborder|
     status_tag joborder.category, joborder.category_tag
   end
    column :company_name
    column :system
    column :technical1
    column do |joborder|
      link_to("Details", admin_job_order_path(joborder)) + " | " + \
      link_to("Delete", admin_job_order_path(joborder), :method => :delete, :confirm => "Are you sure?")
    end
  end
end
