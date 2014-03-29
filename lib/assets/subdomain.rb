class Subdomain
  def self.matches?(request)
  	if Rails.env.production?
  		if request.domain != "theatrical.co"
    		request.domain.present? && request.domain != "theatrical.co"
	    else
	    	request.subdomain.present? && request.subdomain != "www"
	    end
    end
    if Rails.env.development?
  		if request.domain != "lvh.me"
    		request.domain.present? && request.domain != "lvh.me"
	    else
	    	request.subdomain.present? && request.subdomain != "www"
	    end
    end
  end
end
