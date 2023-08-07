INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_ballas', 'ballas', 1),
('society_ballas_black', 'ballas black', 1),
('society_bloods', 'bloods', 1),
('society_bloods_black', 'famillies black', 1),
('society_famillies', 'famillies', 1),
('society_famillies_black', 'bloods black', 1),
('society_marabunta', 'marabunta', 1),
('society_marabunta_black', 'marabunta black', 1),
('society_vagos', 'vagos', 1),
('society_vagos_black', 'vagos black', 1);

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_ballas', 0, NULL),
('society_ballas_black', 0, NULL),
('society_famillies', 0, NULL),
('society_famillies_black', 0, NULL),
('society_bloods', 0, NULL),
('society_bloods_black', 0, NULL),
('society_marabunta', 0, NULL),
('society_marabunta_black', 0, NULL),
('society_vagos', 0, NULL),
('society_vagos_black', 0, NULL);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_ballas', 'ballas', 1),
('society_bloods', 'bloods', 1),
('society_famillies', 'famillies', 1),
('society_marabunta', 'marabunta', 1),
('society_vagos', 'vagos', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_ballas', 'ballas', 1),
('society_bloods', 'bloods', 1),
('society_famillies', 'famillies', 1),
('society_marabunta', 'marabunta', 1),
('society_vagos', 'vagos', 1);

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
('society_ballas', NULL, '{}'),
('society_famillies', NULL, '{}'),
('society_marabunta', NULL, '{}'),
('society_bloods', NULL, '{}'),
('society_vagos', NULL, '{}');

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('ballas', 'Ballas', 0),
('bloods', 'Bloods', 0),
('famillies', 'Famillies', 0),
('marabunta', 'Marabunta', 0),
('vagos', 'Vagos', 0);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('famillies', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('famillies', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('famillies', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('famillies', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('ballas', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('ballas', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('ballas', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('ballas', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('vagos', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('vagos', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('vagos', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('vagos', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('bloods', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('bloods', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('bloods', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('bloods', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('marabunta', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('marabunta', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('marabunta', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('marabunta', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null');