var Donate = {

	/**
	 * Initialize donation panel
	 * Make first tab active
	 */
	init: function()
	{
		$(document).ready(function()
		{
			$('#donate_select a:nth-child(1)').trigger('click');
		});
	},
	
	/**
	 * Show the PayPal donation area
	 * @param Object button
	 */
	showPayPal: function(button)
	{
		$(".nice_active").removeClass("nice_active");
		$(button).addClass("nice_active");

		$("#paygol_area").hide();
		$("#paymentwall_area").hide();
		$("#paypal_area").show();
	},

	/**
	 * Show the PayGol donation area
	 * @param Object button
	 */
	showPayGol: function(button)
	{
		$(".nice_active").removeClass("nice_active");
		$(button).addClass("nice_active");

		$("#paypal_area").hide();
		$("#paymentwall_area").hide();
		$("#paygol_area").show();
	},

	/**
	 * Show the Paymentwall donation area
	 * @param Object button
	 */
	showPaymentwall: function(button)
	{
		$(".nice_active").removeClass("nice_active");
		$(button).addClass("nice_active");

		$("#paypal_area").hide();
		$("#paygol_area").hide();
		$("#paymentwall_area").show();
	}
}

Donate.init();