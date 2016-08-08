<?php

class Donate_model extends CI_Model 
{
	public function getDonationLog($type = 'paypal')
	{
		switch($type)
		{
			case 'paypal':
				$query = $this->db->query("SELECT * FROM paypal_logs ORDER BY `timestamp` DESC LIMIT 10");
				break;
			case 'paygol':
				$query = $this->db->query("SELECT * FROM `paygol_logs` ORDER BY `timestamp` DESC LIMIT 10");
				break;
			case 'paymentwall':
				$query = $this->db->query("SELECT * FROM `paymentwall_logs` ORDER BY `timestamp` DESC LIMIT 10");
				break;
		}

		return isset($query) && $query->num_rows() ? $query->result_array() : false;
	}

	public function giveDp($user, $dp)
	{
		$this->db->query("UPDATE account_data SET dp = dp + ? WHERE id=?", array($dp, $user));
	}

	public function getMonthlyIncome()
	{
		$query = $this->db->query("SELECT * FROM monthly_income ORDER BY month ASC");

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function findByEmail($type, $string)
	{
		$query = $this->db->query("SELECT * FROM ".$type."_logs WHERE `payer_email` LIKE ?", array("%".$string."%"));

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function findByTxn($type, $string)
	{
		$query = $this->db->query("SELECT * FROM ".$type."_logs WHERE `txn_id` LIKE ?", array("%".$string."%"));

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function findById($type, $string)
	{
		$query = $this->db->query("SELECT * FROM ".$type."_logs WHERE `".(($type == "paygol")?"custom":"user_id")."`=?", array($string));

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function getPayPalLog($id)
	{
		$query = $this->db->query("SELECT * FROM paypal_logs WHERE id=?", array($id));

		return $query->num_rows() ? $query->row_array() : false;
	}

	public function findByMessageId($type, $string)
	{
		$query = $this->db->query("SELECT * FROM ".$type."_logs WHERE `message_id`=?", array($string));

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function findByNumber($type, $string)
	{
		$query = $this->db->query("SELECT * FROM ".$type."_logs WHERE `sender`=?", array($string));

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function findBySignature($type, $string)
	{
		$query = $this->db->query("SELECT * FROM ".$type."_logs WHERE `signature` = ?", array($string));

		return $query->num_rows() ? $query->result_array() : false;
	}

	public function updatePayPal($id, $data)
	{
		$this->db->where('id', $id);
		$this->db->update('paypal_logs', $data);
	}

	/**
	 * Update the monthly income log
	 * @param Int $payment_amount
	 */
	public function updateMonthlyIncome($payment_amount)
	{
		$query = $this->db->query("SELECT COUNT(*) AS `total` FROM monthly_income WHERE month=?", array(date("Y-m")));

		$row = $query->result_array();

		if($row[0]['total'])
		{
			$this->db->query("UPDATE monthly_income SET amount = amount + ".floor($payment_amount)." WHERE month=?", array(date("Y-m")));
		}
		else
		{
			$this->db->query("INSERT INTO monthly_income(month, amount) VALUES(?, ?)", array(date("Y-m"), floor($payment_amount)));
		}
	}
}
