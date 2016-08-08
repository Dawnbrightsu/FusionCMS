<?php
class Ipb4 extends Plugin 
{ 
    private $username; 
    private $password; 
    private $email; 
    private $db; 

    public function register($username, $password, $email) 
    { 
        $this->username = $username; 
        $this->password = $password; 
        $this->email = $email; 

        $this->db = $this->CI->load->database($this->CI->config->item('bridge'), TRUE); 

        $this->process(); 
    } 

    private function process() 
    { 
        $salt = $this->generatePasswordSalt(5); 
        $salt = str_replace( '\\', "\\\\", $salt ); 

        $password = $this->encryptPassword($salt); 

        $key = $this->generateAutoLoginKey(); 
        $expire = time() + 86400; 

        $this->db->query("INSERT INTO ".$this->CI->config->item('forum_table_prefix'). 
            "core_members(`name`, `member_group_id`, `email`, `joined`, `member_login_key`, `members_pass_hash`, `members_pass_salt`, `member_login_key_expire`, `members_seo_name`)  
            VALUES(?, '3', ?, ?, ?, ?, ?, ?, ?)",  
            array($this->username, $this->email, time(), $key, $password, $salt, $expire, $this->username)); 
    } 

    private function encryptPassword($salt) 
    { 
        return md5( md5($salt) . md5( $this->password ) ); 
    } 

    private function generateAutoLoginKey( $len=60 ) 
    { 
        $pass = $this->generatePasswordSalt( $len ); 

        return md5($pass); 
    } 

    private function generatePasswordSalt($len=5) 
    { 
        $salt = ''; 
        for ( $i = 0; $i < $len; $i++ ) 
        { 
            $num   = mt_rand(33, 126); 
            if ( $num == '92' ) 
            { 
                $num = 93; 
            } 
            $salt .= chr( $num ); 
        } 
        return $salt; 
    } 
}