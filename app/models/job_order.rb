class JobOrder < ActiveRecord::Base

  validates :company_name,
            :category,
            :system,
            :technical1, :presence => true

  STATUS_PENDING = 'PENDING'
  STATUS_COMPLETED  = 'COMPLETED'
  CATEGORY_SERVICE = 'SERVICE'
  CATEGORY_INSTALLATION = 'INSTALLATION'

   class << self
      def category_collection
       {
        "SERVICE" => CATEGORY_SERVICE,
        "INSTALLATION" => CATEGORY_INSTALLATION
       }
      end
      def status_collection
       {
        "PENDING" => STATUS_PENDING,
        "COMPLETE" => STATUS_COMPLETED
       }
      end
   end
   def status_tag
        case self.status
          when STATUS_PENDING then :error
          when STATUS_COMPLETED then :ok
        end
   end
    def category_tag
        case self.category
          when CATEGORY_SERVICE then :warning
          when CATEGORY_INSTALLATION then :warning
        end
   end

end
