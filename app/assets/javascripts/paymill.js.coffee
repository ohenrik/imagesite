$(document).ready ->

	$("#payment-form").submit (event) ->

	    # Deactivate submit button to avoid further clicks
	    $(".submit-button").attr "disabled", "disabled"
	    paymill.createToken
	      number: $(".card-number").val() # required, ohne Leerzeichen und Bindestriche
	      exp_month: $(".card-expiry-month").val() # required
	      exp_year: $(".card-expiry-year").val() # required, vierstellig z.B. "2016"
	      cvc: $(".card-cvc").val() # required
	      amount_int: $(".card-amount-int").val() # required, integer, z.B. "15" für 0,15 Euro
	      currency: $(".card-currency").val() # required, ISO 4217 z.B. "EUR" od. "GBP"
	      cardholder: $(".card-holdername").val() # optional
	    , PaymillResponseHandler # Info dazu weiter unten
	    event.preventDefault()


	PaymillResponseHandler = (error, result) ->
		if error

			# Shows the error above the form
			$(".payment-errors").text error.apierror
			$(".submit-button").removeAttr "disabled"
			alert error.apierror
		else
			form = $("#payment-form")
			$(".submit-button").removeAttr "disabled"
			# Output token
			token = result.token

			# Insert token into form in order to submit to server
			form.append "<input type='hidden' name='paymillToken' value='" + token + "'/>"
			form.get(0).submit()
		return