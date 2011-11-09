ActiveAdmin.register JobOrder do

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
     f.input :technical1, :label => "Team Leader"
     f.input :technical2, :label => "Technical"
     f.input :todo, :input_html => { :rows => 4 }, :label => "Things To do"
     f.input :work_done, :input_html => { :rows => 4 }, :label => "Works Done"
     f.input :remarks, :input_html => { :rows => 4 }, :label => "Remarks"
     f.input :status, :collection => JobOrder.status_collection, :as => :radio, :hint => "YOU NEED TO PICK ONE STATUS", :include_blank => false

    end
    f.buttons
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
