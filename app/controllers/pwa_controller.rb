class PwaController < ApplicationController
  def manifest
    render template: 'pwa/manifest'
  end

  def service_worker
    render template: 'pwa/service_worker'
  end
end
