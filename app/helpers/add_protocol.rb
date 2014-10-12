module AddProtocol
  def add_protocol
    unless self.url.nil? || self.url.strip.empty?
      unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//] || self.url.strip.empty?
        self.url = "http://#{self.url}"
      end  
    end
  end
end