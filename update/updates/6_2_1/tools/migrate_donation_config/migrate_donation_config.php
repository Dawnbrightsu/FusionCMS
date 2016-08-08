<?php

/**
 * Appends the new paymentwall config section to the 
 * existing donation config.
 */

class Migrate_donation_config
{
	public $version = "6.2.1";
	public $name = "Migrate donation config for Paymentwall";

	public function run()
	{
		// read current config
		$path = '../application/modules/donate/config/donate.php';

		$file = file_get_contents($path);

		// check if PW donation config exists
		if (strpos($file, 'Paymentwall Donation (www.paymentwall.com)') !== false)
			return 'Your donation config seems to be already up to date.';

		if ( ! $file)
			return 'Error reading original donation config file ('.realpath($path).').';

		// insert new config items
		$new = "/*
|--------------------------------------------------------------------------
| Paymentwall Virtual Currency Donation (www.paymentwall.com)
|--------------------------------------------------------------------------
*/

\$config['donate_paymentwall'] = array(
	'use'         => false,
	'key'         => 'YOUR KEY',
	'secret_key'  => 'YOUR SECRET KEY',
	'widget_code' => 'YOUR WIDGET CODE (p1_*)',

	// Test mode (used for Paymentwall approval)
	// When enabled, only the user with the given ID will be able to use the
	// Paymentwall donation, even if Paymentwall is disabled.
	// You can create a test user dedicated for the approval.
	'test_mode'   => false,
	'test_user'   => 1,
);

";
		$find = '/*******************************************************************/
/******************* Only Jesper allowed ***************************/
/*******************************************************************/';

		$file = str_replace($find, $new.$find, $file);

		if ( ! file_put_contents($path, $file) )
			return 'Error writing updated donation config, please check file rights ('.realpath($path).').';

		return "Donation config migration successful.<br />
		        You can now configure Paymentwall in your admin panel under 'Dashboard -> Installed Modules -> Donate -> Edit configs'";
	}
}