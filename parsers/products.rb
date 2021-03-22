nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

#extract title
product['title'] = nokogiri.at_css('.prod-ProductTitle').attr('content').text.strip

#extract current price
product['current_price'] = nokogiri.at_css('span.price-characteristic').attr('content').to_f

#extract rating
rating = nokogiri.at_css('.stars-container').attr('aria-label').text.match(/^\d*/).to_i
product['rating'] = rating == 0 ? nil : rating

#extract number of reviews
review_text = okogiri.at_css('.stars-container').attr('aria-label').text.match(/^\d*/).to_i
product['reviews_count'] = review_text == 0 ? nil : review_text

#extract publisher
product['publisher'] = nokogiri.at_css('a.prod-brandName')[0].text.strip

#extract walmart item number
product['walmart_number'] = nokogiri.at_css('.valign-middle').text.split('#').last.strip

#extract product image
product['img_url'] = nokogiri.at_css('.prod-hero-image img').attr("src").split('?').first

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product