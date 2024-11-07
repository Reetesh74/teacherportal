class PwaController < ApplicationController
    def manifest
        render template: 'pwa/manifest'  # Render the manifest.json.erb template
      end
    
      def service_worker
        render template: 'pwa/service_worker'  # Render the service worker file if needed
      end
end
