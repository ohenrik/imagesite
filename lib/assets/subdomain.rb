class Subdomain
  def self.matches?(request)

      # Check to see if the user is on an alias domain or regular subdomain... or nothing
      if !%w(lvh.me theatrical.co theatrical.no theatrical.de).include?(request.domain)
        request.domain.present? && !%w(lvh.me theatrical.co theatrical.no theatrical.de).include?(request.domain)
      else
        request.subdomain.present? && request.subdomain != "www"
      end

  end
end
