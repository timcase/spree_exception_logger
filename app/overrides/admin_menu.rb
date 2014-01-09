Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "exceptions_admin_tab",
                     :insert_bottom => "[data-hook='admin_tabs']",
                     :text => "<%= tab(:exceptions, :icon => 'icon-file %>",
                     :disabled => false)
