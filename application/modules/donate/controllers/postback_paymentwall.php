<?php

class Postback_paymentwall extends MX_Controller
{
	private $ipsWhitelist = array(
		'174.36.92.186',
		'174.36.96.66',
		'174.36.92.187',
		'174.36.92.192',
		'174.37.14.28'
	);

	private $currency;
	private $uid;

	/**
	 * Load the config options
	 */
	public function __construct()
	{
		parent::__construct();

		$this->load->config('donate');
		$this->pm_config = $this->config->item('donate_paymentwall');
	}

	/**
	 * Handle the pingback request
	 */
	public function index()
	{
		if ( ! in_array($this->input->ip_address(), $this->ipsWhitelist))
		{
			die("WRONG IP");
		}

		$params = array();
		foreach ($_GET as $key => $value)
			$params[$key] = $value;

		unset($params['sig']);

		$log_data = array(
			'user_id' => $this->input->get('uid'),
			'signature' => $this->input->get('sig'),
			'dp_amount' => $this->input->get('currency'),
			'type' => $this->input->get('type'),
			'ref' => $this->input->get('ref'),
			'timestamp' => time(),
		);

		// verify signature
		if ($this->input->get('sig') == $this->calculatePingbackSignature($params))
		{
			// ok, update DPs (this also handles chargebacks)
			$this->currency = $this->input->get('currency');
			$this->db->query("UPDATE `account_data` SET `dp` = `dp` + ? WHERE `id` = ?", array($this->currency, $this->input->get('uid')));

			$this->updateMonthlyIncome();
			
			// insert log
			$log_data['status'] = 'success';
			$this->db->insert('paymentwall_logs', $log_data);
			$this->plugins->onDonationPostback($this->input->get('uid'), true, -1, $this->currency);
		
			die("OK");
		}
		else
		{
			// insert log
			$log_data['status'] = 'failed';
			$this->db->insert('paymentwall_logs', $log_data);
			$this->plugins->onDonationPostback($this->input->get('uid'), false, -1, $this->currency);
		
			die("WRONG SIGNATURE");
		}
	}

	/**
	 * Calculate the signature value
	 * @return String
	 */
	private function calculatePingbackSignature($params)
	{
	    // work with sorted data
	    ksort($params);

	    // generate the base string
	    $baseString = '';

	    foreach($params as $key => $value) {
	        $baseString .= $key . '=' . $value;
	    }

	    $baseString .= $this->pm_config['secret_key'];

	    return md5($baseString);
	}  

	/**
	 * Keep track of the monthly income
	 */
	private function updateMonthlyIncome()
	{
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM monthly_income WHERE month=?", array(date("Y-m")));

		$row = $query->result_array();

		if($row[0]['total'])
		{
			$this->db->query("UPDATE monthly_income SET amount = amount + ".$this->currency." WHERE month=?", array(date("Y-m")));
		}
		else
		{
			$this->db->query("INSERT INTO monthly_income(month, amount) VALUES(?, ?)", array(date("Y-m"), floor($this->currency)));
		}
	} 
}
