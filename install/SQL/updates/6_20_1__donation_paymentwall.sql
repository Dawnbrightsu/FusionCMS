CREATE TABLE `paymentwall_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `type` int(11) unsigned NOT NULL,
  `signature` varchar(32) NOT NULL DEFAULT '',
  `ref` varchar(255) DEFAULT '',
  `status` enum('success','failed') NOT NULL DEFAULT 'failed',
  `dp_amount` int(11) DEFAULT NULL,
  `timestamp` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;