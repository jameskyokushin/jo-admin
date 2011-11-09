ActiveAdmin.register JobOrder do
  form do |f|
  
    f.inputs "Company Details" do
      f.input :company_name
      f.input :contact_person 
      f.input :contact_number
      f.input :address
    end
    f.inputs "Job Order" do
      f.input :category, :as => :radio,:collection => [["Service","Service"],["Installation","Installation"]]
      f.input :system,:collection => [["- Select -","  "],["Automatic Gates"," Automatic Gates"],["Metal Detectors","Metal Detectors"],["CCTV","CCTV"],["Access Control","Access Control"],["Intrusion","Intrusion"],["Fire Alarm","Fire Alarm"],["Light Automation","Light Automation"],["Automated Window Treatment","Automated Window Treatment"],["Home Run","Home Run"],["Installation Accessories","Installation Accessories"],["Cable","Cable"],["Radio","Radio"],["Voip","Voip"],["Network Cabinet","Network Cabinet"],["Public Address System","Public Address System"],["Telecom","Telecom"],["Id Printer","Id Printer"],["Pc Pheripherals","Pc Pheripherals"],["Card","Card"],["Networking","Networking"],["Door Automation","Door Automation"],["Parking System","Parking System"],["Turnstile","Turnstile"],["Others","Others"]], :include_blank => false
     f.input :technical1, :label => "Team Leader"
     f.input :technical2, :label => "Technical"
     f.input :todo, :input_html => { :rows => 4 }, :label => "Things To do"
     f.input :work_done, :input_html => { :rows => 4 }, :label => "Works Done"
     f.input :remarks, :input_html => { :rows => 4 }, :label => "Remarks"
     f.input :status

    end
    f.buttons
  end
  
  


end
