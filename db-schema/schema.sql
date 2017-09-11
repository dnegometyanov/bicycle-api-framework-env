CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `amount` float NOT NULL,
  `status` enum('rejected','approved') NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;