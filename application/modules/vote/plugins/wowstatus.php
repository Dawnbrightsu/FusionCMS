<?php

class Wowstatus extends Plugin
{
	private $url = "wowstatus.net";

	public function callback()
	{
		$this->CI->load->model('vote/vote_model');

		//Get the account id of the guy that voted, this id was sent from the site.
		$account_id = $this->CI->input->post('user');
		
		if ( ! $account_id || $this->CI->input->ip_address() != gethostbyname('wowstatus.net'))
			die('No access');
		
		$vote_site = $this->CI->vote_model->getVoteSiteByUrl($this->url);
		
		if($this->CI->vote_model->canVote($vote_site['id']))
		{
			//Give him the amount of vote points that he gets for it.
			$this->CI->vote_model->vote_log($account_id, $this->CI->input->ip_address(), $vote_site['id']);
			$this->CI->vote_model->updateVp($account_id, $vote_site['points_per_vote']);

			$this->CI->plugins->onVote($account_id, $vote_site);

			die('Points given');
		}

		die('No points given');
	}
}