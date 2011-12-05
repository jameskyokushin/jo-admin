include ActionView::Helpers::NumberHelper

def generate_joborder(joborder)
  # Generate invoice
  Prawn::Document.generate @joborder.joborder_location do |pdf|
    # Title
    #pdf.text "Invoice ##{invoice.code}", :size => 25

    # Client info
    #pdf.text invoice.client.name
    #pdf.text invoice.client.address
    #pdf.text invoice.client.phone

    #pdf.draw_text "#{t('.created_at')}: #{l(invoice.created_at, :format => :short)}", :at => [pdf.bounds.width / 2, pdf.bounds.height - 30]

    # Our company info
    # pdf.float do
    #   pdf.bounding_box [0, pdf.bounds.top - 5], :width => pdf.bounds.width do
    #     pdf.text invoice.client.company.name, :size => 20, :align => :right
    #   end
    # end

    pdf.move_down 20

    # Items
    header = ['Qty.', 'Description', 'Amount', 'Total']
    items = invoice.items.collect do |item|
      [item.quantity.to_s, item.description, number_to_currency(item.amount), number_to_currency(item.total)]
    end
    
    items = items + [["", "", "Discount:", "#{number_with_delimiter(invoice.discount)}%"]] \
                  + [["", "", "Sub-total:", "#{number_to_currency(invoice.subtotal)}"]] \
                  + [["", "", "Taxes:", "#{number_to_currency(invoice.taxes)} (#{number_with_delimiter(invoice.tax)}%)"]] \
                  + [["", "", "Total:", "#{number_to_currency(invoice.total)}"]]
h
    pdf.table [header] + items, :header => true, :width => pdf.bounds.width do
      row(-4..-1).borders = []
      row(-4..-1).column(2).align = :right
      row(0).style :font_style => :bold
      row(-1).style :font_style => :bold
    end
    
                     # :border_style => :grid, 
                     # :headers => header, 
                     # :width => pdf.bounds.width, 
                     # :row_colors => %w{cccccc eeeeee},
                     # :align => { 0 => :right, 1 => :left, 2 => :right, 3 => :right, 4 => :right }


    # Terms
    if invoice.terms != ''
      pdf.move_down 20
      pdf.text 'Terms', :size => 18
      pdf.text invoice.terms
    end

    # Notes
    if invoice.notes != ''
      pdf.move_down 20
      pdf.text 'Notes', :size => 18
      pdf.text invoice.notes
    end

    # Footer
    pdf.draw_text "Generated at #{l(Time.now, :format => :short)}", :at => [0, 0]
  end
end

ActiveAdmin.register JobOrder do

 # -----------------------------------------------------------------------------------
  # PDF
  
  action_item :only => :show do
    link_to "Generate PDF", generate_pdf_admin_job_order_path(resource)
  end
  
  member_action :generate_pdf do
    @joborder = JobOrder.find(params[:id])
    generate_joborder(@joborder)
    
  end

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
     f.input :technical1, :label => "Team Leader"
     f.input :technical2, :label => "Technical"
     f.input :todo, :input_html => { :rows => 4 }, :label => "Things To do"
     f.input :work_done, :input_html => { :rows => 4 }, :label => "Works Done"
     f.input :remarks, :input_html => { :rows => 4,  }, :label => "Notes"
     f.input :status, :collection => JobOrder.status_collection, :hint => "YOU NEED TO PICK ONE STATUS", :include_blank => false, :wrapper_html => { :style => "display:none;" }
     f.input :prepared_by,  :collection => [["- Auto Generated -","ADMIN"]], :wrapper_html => { :style => "display:none;" }, :include_blank => false

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
    column :prepared_by
    column do |joborder|
      link_to("Details", admin_job_order_path(joborder)) + " | " + \
      link_to("Delete", admin_job_order_path(joborder), :method => :delete, :confirm => "Are you sure?")
    end
  end
end
