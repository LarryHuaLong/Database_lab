-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 2018-06-29 06:37:52
-- 服务器版本： 5.7.21
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mymtime`
--

DELIMITER $$
--
-- 存储过程
--
DROP PROCEDURE IF EXISTS `orderticket`$$
CREATE DEFINER=`mymtime`@`%` PROCEDURE `orderticket` (IN `U_ID` INT UNSIGNED, IN `S_ID` INT UNSIGNED)  MODIFIES SQL DATA
    COMMENT '定票过程'
BEGIN
DECLARE leftTickets SMALLINT;
	START TRANSACTION;
    
	UPDATE `show` 
	SET `show`.`S_tickets_left`=`show`.`S_tickets_left`-1
    WHERE `show`.S_ID=S_ID;
    
    SELECT `show`.S_tickets_left INTO leftTickets
    FROM`show` WHERE `show`.S_ID=S_ID;
    
    IF leftTickets<0 THEN
    	ROLLBACK; 
    ELSE
    	INSERT INTO `tickets` VALUES (U_ID,S_ID);
    	COMMIT;
	END IF;   
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `actin`
--

DROP TABLE IF EXISTS `actin`;
CREATE TABLE IF NOT EXISTS `actin` (
  `P_ID` int(11) NOT NULL COMMENT '演员ID',
  `F_ID` int(11) NOT NULL COMMENT '电影ID',
  `role` char(40) COLLATE gbk_bin DEFAULT NULL COMMENT '参演角色名',
  `role_img_url` varchar(100) COLLATE gbk_bin DEFAULT NULL COMMENT '角色图片',
  PRIMARY KEY (`P_ID`,`F_ID`),
  KEY `F_ID` (`F_ID`),
  KEY `P_ID` (`P_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COLLATE=gbk_bin COMMENT='参演表';

--
-- 转存表中的数据 `actin`
--

INSERT INTO `actin` (`P_ID`, `F_ID`, `role`, `role_img_url`) VALUES
(893026, 12231, '安迪 Andy Dufresne', 'http://img31.mtime.cn/mg/2014/03/06/095801.37640458_60X60X4.jpg'),
(914747, 12231, '瑞德  Ellis Boyd \'Red\' Redding', 'http://img31.mtime.cn/mg/2014/03/06/100012.83373613_60X60X4.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `favoritemovie`
--

DROP TABLE IF EXISTS `favoritemovie`;
CREATE TABLE IF NOT EXISTS `favoritemovie` (
  `U_ID` int(11) NOT NULL,
  `F_ID` int(11) NOT NULL,
  PRIMARY KEY (`U_ID`,`F_ID`),
  KEY `F_ID` (`F_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

--
-- 转存表中的数据 `favoritemovie`
--

INSERT INTO `favoritemovie` (`U_ID`, `F_ID`) VALUES
(1, 10054),
(1, 12135),
(1, 12231),
(3, 17926),
(1, 99547),
(1, 105646),
(1, 225759),
(1, 234873),
(2, 250595);

-- --------------------------------------------------------

--
-- 表的结构 `favoritepeople`
--

DROP TABLE IF EXISTS `favoritepeople`;
CREATE TABLE IF NOT EXISTS `favoritepeople` (
  `U_ID` int(11) NOT NULL,
  `P_ID` int(11) NOT NULL,
  PRIMARY KEY (`U_ID`,`P_ID`),
  KEY `P_ID` (`P_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

--
-- 转存表中的数据 `favoritepeople`
--

INSERT INTO `favoritepeople` (`U_ID`, `P_ID`) VALUES
(1, 893017),
(3, 893017),
(1, 901366),
(1, 911757),
(2, 911757),
(1, 915334),
(1, 924124),
(1, 951204),
(2, 951204);

--
-- 触发器 `favoritepeople`
--
DROP TRIGGER IF EXISTS `addfavorite`;
DELIMITER $$
CREATE TRIGGER `addfavorite` AFTER INSERT ON `favoritepeople` FOR EACH ROW BEGIN
UPDATE people SET P_count = P_count + 1 WHERE P_ID = new.P_ID;

END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `removefavorite`;
DELIMITER $$
CREATE TRIGGER `removefavorite` AFTER DELETE ON `favoritepeople` FOR EACH ROW BEGIN
UPDATE people SET P_count = P_count - 1 WHERE P_ID = old.P_ID;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 表的结构 `films`
--

DROP TABLE IF EXISTS `films`;
CREATE TABLE IF NOT EXISTS `films` (
  `F_ID` int(11) NOT NULL COMMENT '电影ID',
  `F_name_zh` char(40) COLLATE gbk_bin DEFAULT NULL COMMENT '电影中文名',
  `F_name_en` varchar(40) COLLATE gbk_bin DEFAULT NULL COMMENT '电影英文名',
  `F_year` year(4) DEFAULT NULL COMMENT '电影年代',
  `F_runtime` smallint(6) DEFAULT NULL COMMENT '电影时长',
  `F_genre` char(40) COLLATE gbk_bin DEFAULT NULL COMMENT '类型',
  `F_releaseDate` date DEFAULT NULL COMMENT '发布日期',
  `F_is3D` char(1) COLLATE gbk_bin DEFAULT NULL COMMENT '是否3D',
  `F_grade` tinyint(4) DEFAULT NULL COMMENT '评分',
  `F_directorID` int(11) DEFAULT NULL COMMENT '导演ID',
  `F_nation` char(20) COLLATE gbk_bin DEFAULT NULL COMMENT '国家地区',
  `F_img_url` varchar(100) COLLATE gbk_bin DEFAULT NULL COMMENT '电影海报url',
  PRIMARY KEY (`F_ID`),
  KEY `films_ibfk_1` (`F_directorID`),
  KEY `grade` (`F_grade`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk COLLATE=gbk_bin COMMENT='电影表';

--
-- 转存表中的数据 `films`
--

INSERT INTO `films` (`F_ID`, `F_name_zh`, `F_name_en`, `F_year`, `F_runtime`, `F_genre`, `F_releaseDate`, `F_is3D`, `F_grade`, `F_directorID`, `F_nation`, `F_img_url`) VALUES
(10054, '阿甘正传', 'Forrest Gump', 1994, 142, '剧情/爱情', '1994-06-23', 'N', 91, 897737, '美国', 'http://img31.mtime.cn/mg/2014/06/17/145458.79721395_270X405X4.jpg'),
(10190, '霸王别姬', 'Farewell My Concubine', 1993, 171, '爱情/剧情/音乐', '1993-01-01', 'N', 90, 892816, '中国', 'http://img31.mtime.cn/mg/2014/03/12/145744.58512488_270X405X4.jpg'),
(10717, '鬼子来了', 'Devils on the Doorstep', 2000, 139, '剧情/战争', '2000-05-12', 'N', 87, 892871, '中国', 'http://img31.mtime.cn/mt/2014/02/22/224614.64675869_270X405X4.jpg'),
(10968, '教父', 'The Godfather', 1972, 175, '犯罪/剧情', '1972-03-24', 'N', 91, 896804, '美国', 'http://img5.mtime.cn/mg/2017/01/24/151610.54986635_270X405X4.jpg'),
(12135, '卧虎藏龙', 'Crouching Tiger, Hidden Dragon', 2000, 120, '武侠/动作/爱情', '2000-07-07', 'N', 75, 892883, '中国|美国', 'http://img31.mtime.cn/mt/2014/02/22/230335.60382742_96X128.jpg'),
(12231, '肖申克的救赎', 'The Shawshank Redemption', 1994, 142, '犯罪/剧情', '1994-09-23', 'N', 92, 897895, '美国', 'http://img31.mtime.cn/mt/2014/03/07/123549.37376649_270X405X4.jpg'),
(12281, '辛德勒的名单', 'Schindler\'s List', 1993, 195, '传记/剧情/历史', '1994-02-04', 'N', 91, 892793, '美国', 'http://img31.mtime.cn/mt/2013/11/29/102947.25583478_270X405X4.jpg'),
(12469, '英雄', 'Hero', 2002, 99, ' 动作/剧情/冒险', '2002-10-24', 'N', 62, 893000, '中国', 'http://img31.mtime.cn/mt/2014/02/22/230715.32438109_96X128.jpg'),
(12599, '这个杀手不太冷', 'Léon', 1994, 110, '冒险/家庭', '2008-06-27', 'N', 90, 892773, '法国', 'http://img31.mtime.cn/mg/2014/09/12/102735.29315066_270X405X4.jpg'),
(13367, '十二怒汉', '12 Angry Men', 1957, 96, '剧情', '1957-04-10', 'N', 91, 895898, '美国', 'http://img31.mtime.cn/mg/2016/07/28/145308.32944941_270X405X4.jpg'),
(17926, '功夫', 'Kung Fu Hustle', 2004, 100, '动作/奇幻/犯罪', '2015-01-15', 'Y', 74, 893017, '中国', 'http://img31.mtime.cn/mt/2014/12/23/094110.39603129_96X128.jpg'),
(19335, '无极', 'The Promise', 2005, 120, '动作/奇幻/剧情', '2005-12-15', 'N', 49, 892816, '中国|韩国|日本', 'http://img31.mtime.cn/mt/2014/02/23/003808.99804523_96X128.jpg'),
(46109, ' 长江7号', 'CJ7', 2008, 86, '奇幻/家庭/剧情', '2018-01-30', 'N', 66, 893017, '中国', 'http://img31.mtime.cn/mt/2014/02/23/034015.53648625_270X405X4.jpg'),
(52952, '机器人总动员', 'WALL·E', 2008, 98, '动画/冒险/家庭', '2008-06-27', 'N', 90, 901366, '美国', 'http://img31.mtime.cn/mt/2013/11/20/172527.42989246_270X405X4.jpg'),
(98604, '海豚湾', 'The Cove', 2009, 92, '记录片/犯罪', '2009-07-31', 'N', 91, 1597641, '美国', 'http://img31.mtime.cn/mg/2016/07/28/145308.32944941_270X405X4.jpg'),
(99547, '盗梦空间', 'Inception', 2010, 148, '动作/冒险/科幻', '2010-09-01', 'N', 91, 892754, '美国|英国', 'http://img31.mtime.cn/mt/2014/01/06/105446.89493583_96X128.jpg'),
(105646, '十二生肖', 'CZ12', 2012, 120, '动作/冒险', '2012-12-20', 'Y', 71, 892908, '中国', 'http://img31.mtime.cn/mt/2012/12/14/172333.13932508_270X405X4.jpg'),
(106313, '让子弹飞', 'Let The Bullets Fly', 2010, 132, '喜剧/动作', '2010-12-16', 'N', 85, 892871, '中国', 'http://img21.mtime.cn/mt/2010/11/23/102316.52177023_270X405X4.jpg'),
(138762, '西游降魔篇', 'Journey to the West:Conquering the Demon', 2013, 110, '冒险/喜剧/奇幻', '2013-02-10', 'Y', 74, 893017, '中国', 'http://img31.mtime.cn/mg/2014/08/08/111320.55434831_270X405X4.jpg'),
(209007, '美人鱼', 'The Mermaid', 2016, 93, '喜剧/奇幻/爱情', '2016-02-08', 'Y', 74, 893017, '中国', 'http://img31.mtime.cn/mg/2016/02/04/165939.70222578_270X405X4.jpg'),
(217497, '复仇者联盟3：无限战争', 'Avengers: Infinity War', 2018, 150, '动作/冒险/奇幻/科幻', '2018-05-11', 'Y', 81, 903229, '美国', 'http://img5.mtime.cn/mt/2018/03/30/101316.99752366_96X128.jpg'),
(220627, '唐人街探案', 'Detective Chinatown', 2015, 135, '喜剧/动作/剧情', '2015-12-31', 'N', 71, 1249267, '中国', 'http://img31.mtime.cn/mg/2016/08/28/144118.99950384_270X405X4.jpg'),
(224595, '游侠索罗：星球大战外传', 'Solo: A Star Wars Story', 2018, 135, '动作/科幻', '2018-05-25', 'Y', 71, 898169, '美国', 'http://img5.mtime.cn/mg/2018/05/04/182348.20558908_270X405X4.jpg'),
(225759, '侏罗纪世界2', 'Jurassic World: Fallen Kingdom', 2018, 128, '动作/冒险/科幻', '2018-06-15', 'Y', 73, 1310397, '美国|西班牙', 'http://img5.mtime.cn/mg/2018/05/25/100001.46893840_270X405X4.jpg'),
(234873, '唐人街探案2', 'Detective Chinatown 2', 2018, 120, '喜剧/动作/悬疑', '2018-02-16', 'N', 70, 1249267, '中国', 'http://img5.mtime.cn/mg/2018/02/05/093620.13079693_270X405X4.jpg'),
(234987, '猛虫过江', 'A strong insect crossing the river', 2018, 100, '喜剧/动作', '2018-06-15', 'N', 47, 1598051, '中国', 'http://img5.mtime.cn/mg/2018/06/05/091820.25452231_270X405X4.jpg'),
(247378, '哆啦A梦：大雄的金银岛', 'Doraemon: Nobita\'s Treasure Island', 2018, 109, '动画/冒险/家庭', '2018-06-01', 'N', 64, 2328291, '日本', 'http://img5.mtime.cn/mg/2018/05/28/103846.94400146_270X405X4.jpg'),
(250595, '泄密者', 'The Leaker', 2018, 102, '犯罪/动作/悬疑', '2018-06-15', 'N', 58, 892937, '中国', 'http://img5.mtime.cn/mg/2018/06/12/144616.30734695_270X405X4.jpg'),
(250729, '超时空同居', 'How Long Will I Love U', 2018, 101, '奇幻/喜剧', '2018-05-18', 'N', 68, 2054611, '中国', 'http://img5.mtime.cn/mg/2018/05/05/175423.17616161_270X405X4.jpg'),
(250858, '寂静之地', 'A Quiet Place', 2018, 90, '剧情/恐怖/惊悚', '2018-05-18', 'N', 71, 928550, '美国', 'http://img5.mtime.cn/mg/2018/05/07/162525.59121165_270X405X4.jpg'),
(253011, '厕所英雄', 'Toilet - Ek Prem Katha', 2017, 155, '剧情/喜剧', '2018-06-08', 'N', 73, 1556332, '印度', 'http://img5.mtime.cn/mg/2018/05/31/190851.98763430_270X405X4.jpg');

-- --------------------------------------------------------

--
-- 表的结构 `people`
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE IF NOT EXISTS `people` (
  `P_ID` int(11) NOT NULL COMMENT '人物ID',
  `P_name_zh` char(40) COLLATE gbk_bin DEFAULT NULL COMMENT '人物中文名',
  `P_name_en` char(20) COLLATE gbk_bin DEFAULT NULL COMMENT '人物英文名',
  `P_gender` char(2) COLLATE gbk_bin NOT NULL COMMENT '性别',
  `P_birthday` date DEFAULT NULL COMMENT '生日',
  `P_height` smallint(6) DEFAULT NULL COMMENT '身高',
  `P_weight` smallint(6) DEFAULT NULL COMMENT '体重',
  `P_position` char(40) COLLATE gbk_bin DEFAULT NULL COMMENT '位置',
  `P_img_url` varchar(100) COLLATE gbk_bin DEFAULT NULL COMMENT '人物头像',
  `P_count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '关注人数',
  PRIMARY KEY (`P_ID`),
  KEY `count` (`P_count`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk COLLATE=gbk_bin COMMENT='人物表';

--
-- 转存表中的数据 `people`
--

INSERT INTO `people` (`P_ID`, `P_name_zh`, `P_name_en`, `P_gender`, `P_birthday`, `P_height`, `P_weight`, `P_position`, `P_img_url`, `P_count`) VALUES
(892754, '克里斯托弗·诺兰', 'Christopher Nolan', '男', '1970-07-30', 180, NULL, '英国 伦敦', 'http://img31.mtime.cn/ph/2014/03/15/190117.20334009_290X440X4.jpg', 0),
(892773, '吕克·贝松', 'Luc Besson', '男', '1959-03-18', 174, 67, '法国 巴黎', 'http://img31.mtime.cn/ph/2016/09/08/170215.62815049_290X440X4.jpg', 0),
(892793, '史蒂文·斯皮尔伯格', 'Steven Spielberg', '男', '1946-12-18', 171, NULL, '美国 俄亥俄 辛辛那提', 'http://img31.mtime.cn/ph/2016/09/04/221007.13528827_290X440X4.jpg', 0),
(892816, '陈凯歌', 'Kaige Chen', '男', '1952-08-12', NULL, NULL, '中国 北京', 'http://img5.mtime.cn/ph/2017/12/26/101402.72669259_290X440X4.jpg', 0),
(892871, '姜文', 'Wen Jiang', '男', '1963-01-05', 183, 90, '中国 河北 唐山', 'http://img5.mtime.cn/ph/2018/02/07/110510.14763357_290X440X4.jpg', 0),
(892883, '李安', 'Ang Lee', '男', '1954-10-23', 178, 64, '中国台湾 屏东 潮州镇', 'http://img31.mtime.cn/ph/2014/03/28/182311.31381196_290X440X4.jpg', 0),
(892908, '成龙', 'Jackie Chan', '男', '1954-04-07', 173, 75, '中国 香港', 'http://img31.mtime.cn/ph/2014/02/28/112422.17365543_290X440X4.jpg', 0),
(892937, '邱礼涛', 'Herman Yau', '男', '1961-01-01', NULL, NULL, '中国 香港', 'http://img31.mtime.cn/ph/2016/03/15/153553.49190867_290X440X4.jpg', 0),
(893000, '张艺谋', 'Yimou Zhang', '男', '1950-04-02', NULL, NULL, '中国 陕西 西安', 'http://img5.mtime.cn/ph/2016/11/15/093310.65955007_290X440X4.jpg', 0),
(893017, '周星驰', 'Stephen Chow', '男', '1962-06-22', 174, 70, '中国 香港', 'http://img31.mtime.cn/ph/2014/06/20/101912.19906894_290X440X4.jpg', 2),
(893026, '蒂姆·罗宾斯', 'Tim Robbins', '男', '1958-10-16', 196, 67, '美国 加州西 柯汶纳', 'http://img31.mtime.cn/ph/2014/10/16/090902.78583267_290X440X4.jpg', 0),
(893397, '约翰尼·德普', 'Johnny Depp', '男', '1963-06-09', 178, NULL, '美国 肯塔基州欧 温斯波洛', 'http://img31.mtime.cn/ph/2014/03/28/162605.15111665_290X440X4.jpg', 0),
(895898, '西德尼·吕美特', 'Sidney Lumet', '男', '1924-06-25', NULL, NULL, '美国宾夕法尼亚州', 'http://img31.mtime.cn/ph/2014/03/14/154346.74196668_290X440X4.jpg', 0),
(896804, '弗朗西斯·福特·科波拉', 'Francis Ford Coppola', '男', '1939-04-07', 179, NULL, '美国密歇根州底特律', 'http://img31.mtime.cn/ph/2014/03/14/153814.86586505_290X440X4.jpg', 0),
(897737, '罗伯特·泽米吉斯', 'Robert Zemeckis', '男', '1952-05-14', NULL, NULL, '美国 伊利诺伊 芝加哥', 'http://img31.mtime.cn/ph/2014/03/14/154105.50385692_290X440X4.jpg', 0),
(897895, '弗兰克·德拉邦特', 'Frank Darabont', '男', '1959-01-28', 178, NULL, '法国杜省蒙贝利亚尔', 'http://img31.mtime.cn/ph/2016/01/28/094446.79677444_290X440X4.jpg', 0),
(898169, '朗·霍华德', 'Ron Howard', '男', '1954-03-01', NULL, NULL, '美国 俄克拉荷马州', 'http://img31.mtime.cn/ph/2014/04/11/161507.99325205_290X440X4.jpg', 0),
(901366, '安德鲁·斯坦顿', 'Andrew Stanton', '男', '1965-12-03', 179, 67, '美国 马萨诸塞 波士顿', 'http://img31.mtime.cn/ph/2014/03/14/153322.61219664_290X440X4.jpg', 1),
(903229, '安东尼·罗素', 'Anthony Russo', '男', '1970-02-03', NULL, NULL, '美国 俄亥俄州', 'http://img31.mtime.cn/ph/2014/03/14/152324.64956342_290X440X4.jpg', 0),
(911751, '斯嘉丽·约翰逊', 'Scarlett Johansson', '女', '1984-11-22', 160, 48, '美国 纽约', 'http://img31.mtime.cn/ph/2014/03/14/152327.29309922_290X440X4.jpg', 0),
(911757, '休·杰克曼', 'Hugh Jackman', '男', '1968-10-12', 190, 89, '澳大利亚 悉尼', 'http://img31.mtime.cn/ph/2014/03/15/210910.39596130_290X440X4.jpg', 2),
(912464, '杰森·斯坦森', 'Jason Statham', '男', '1967-07-26', 178, NULL, '英国 伦敦', NULL, 0),
(914747, '摩根·弗里曼', 'Morgan Freeman', '男', '1937-06-01', 189, 85, '美国 田纳西州 孟菲斯', 'http://img31.mtime.cn/ph/2014/03/14/152553.24862330_290X440X4.jpg', 0),
(915334, '艾玛·沃森', 'Emma Watson', '女', '1990-04-15', 165, 51, '法国 巴黎', 'http://img5.mtime.cn/ph/2017/03/15/144937.54087223_290X440X4.jpg', 1),
(923219, '古天乐', 'Louis Koo', '男', '1970-10-21', 180, 70, '中国 香港', 'http://img5.mtime.cn/ph/2017/08/08/163314.60329162_290X440X4.jpg', 0),
(924124, '安妮·海瑟薇', 'Anne Hathaway', '女', '1982-11-12', 173, 56, '美国 纽约 布鲁克林', 'http://img31.mtime.cn/ph/2016/05/25/094916.61872966_290X440X4.jpg', 1),
(924319, '莱昂纳多·迪卡普里奥', 'Leonardo DiCaprio', '男', '1974-11-11', 183, NULL, '美国 加利福尼亚 洛杉矶', 'http://img31.mtime.cn/ph/2016/01/31/141703.43012792_290X440X4.jpg', 0),
(928550, '约翰·卡拉辛斯基', 'John Krasinski', '男', '1979-10-20', 191, NULL, '美国 马萨诸塞州 牛顿', 'http://img31.mtime.cn/ph/2014/06/26/161242.54458838_290X440X4.jpg', 0),
(951204, '奥黛丽·赫本', 'Audrey Hepburn', '女', '1929-05-04', 170, NULL, '比利时 布鲁塞尔', 'http://img31.mtime.cn/ph/2014/03/14/153619.38395779_290X440X4.jpg', 2),
(1249267, '陈思诚', 'Sicheng Chen', '男', '1978-02-22', 180, 68, '中国 辽宁 沈阳', 'http://img31.mtime.cn/ph/2016/07/21/161347.80148282_290X440X4.jpg', 0),
(1310397, '胡安·安东尼奥·巴亚纳', 'Juan Antonio Bayona', '男', '1975-05-09', NULL, NULL, '西班牙', 'http://img5.mtime.cn/ph/2017/05/04/105004.26245563_290X440X4.jpg', 0),
(1556332, '什里·那拉扬·辛', 'Shree Narayan Singh', '男', NULL, NULL, NULL, NULL, 'http://img31.mtime.cn/ph/332/1556332/1556332_290X440X4.jpg', 0),
(1597641, '路易·西霍尤斯', 'Louie Psihoyos', '男', NULL, NULL, NULL, NULL, 'http://img31.mtime.cn/ph/2014/03/14/154340.61343269_290X440X4.jpg', 0),
(1598051, '小沈阳', 'Xiao Shenyang', '男', '1981-05-08', 174, 60, '中国 辽宁 开原', 'http://img31.mtime.cn/ph/2014/03/16/194139.79353404_290X440X4.jpg', 0),
(2054611, '苏伦', 'Lun Su', '女', NULL, NULL, NULL, '中国', 'http://img5.mtime.cn/ph/2018/03/12/150903.91171659_290X440X4.jpg', 0),
(2328291, '今井一晓', 'Kazuaki Imai', '男', NULL, NULL, NULL, '日本', 'http://img5.mtime.cn/ph/2018/05/24/105000.78050854_290X440X4.jpg', 0);

-- --------------------------------------------------------

--
-- 表的结构 `show`
--

DROP TABLE IF EXISTS `show`;
CREATE TABLE IF NOT EXISTS `show` (
  `S_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一标识电影场次',
  `T_ID` int(11) NOT NULL COMMENT '上映影院ID',
  `F_ID` int(11) NOT NULL COMMENT '上映电影ID',
  `S_start_time` datetime NOT NULL COMMENT '开始时间',
  `S_end_time` datetime NOT NULL COMMENT '结束时间',
  `S_price` tinyint(4) NOT NULL COMMENT '票价',
  `S_tickets_left` smallint(6) NOT NULL COMMENT '余票数',
  PRIMARY KEY (`S_ID`),
  UNIQUE KEY `S_ID` (`S_ID`),
  KEY `F_ID` (`F_ID`),
  KEY `T_ID` (`T_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=gbk COLLATE=gbk_bin COMMENT='上映表';

--
-- 转存表中的数据 `show`
--

INSERT INTO `show` (`S_ID`, `T_ID`, `F_ID`, `S_start_time`, `S_end_time`, `S_price`, `S_tickets_left`) VALUES
(1, 6226, 225759, '2018-06-19 19:50:00', '2018-06-19 21:58:00', 43, 84),
(2, 6226, 225759, '2018-06-30 00:00:00', '2018-07-01 02:00:00', 45, 0),
(3, 6226, 234987, '2018-06-20 10:10:00', '2018-06-19 11:49:00', 39, 64),
(4, 6226, 247378, '2018-07-05 11:16:00', '2018-07-05 13:24:21', 39, 56),
(5, 6226, 250595, '2018-07-03 09:00:00', '2018-07-03 11:24:00', 33, 22),
(6, 6226, 225759, '2018-06-30 04:00:10', '2018-06-28 06:17:12', 33, 34),
(7, 1821, 12231, '2018-06-19 19:50:00', '2018-06-19 21:58:00', 43, 84),
(8, 1821, 224595, '2018-06-30 00:00:00', '2018-07-01 02:00:00', 45, 0),
(9, 1821, 225759, '2018-06-20 10:10:00', '2018-06-19 11:49:00', 39, 64),
(10, 1821, 225759, '2018-07-05 11:16:00', '2018-07-05 13:24:21', 39, 54),
(11, 1821, 225759, '2018-07-03 09:00:00', '2018-07-03 11:24:00', 33, 22),
(12, 1821, 98604, '2018-06-30 04:00:10', '2018-06-28 06:17:12', 33, 34);

-- --------------------------------------------------------

--
-- 表的结构 `theaters`
--

DROP TABLE IF EXISTS `theaters`;
CREATE TABLE IF NOT EXISTS `theaters` (
  `T_ID` int(11) NOT NULL COMMENT '影院ID',
  `T_name` char(40) COLLATE gbk_bin NOT NULL COMMENT '影院名称',
  `T_area` char(20) COLLATE gbk_bin NOT NULL COMMENT '影院所在地区',
  `T_address` char(40) COLLATE gbk_bin DEFAULT NULL COMMENT '影院地址',
  PRIMARY KEY (`T_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COLLATE=gbk_bin COMMENT='影院表';

--
-- 转存表中的数据 `theaters`
--

INSERT INTO `theaters` (`T_ID`, `T_name`, `T_area`, `T_address`) VALUES
(1821, '中影国际影城武汉光谷天河店', '洪山区', '湖北武汉市东湖开发区光谷世界城C座三楼'),
(6226, 'CGV影城（光谷IMAX店）', '洪山区', '武汉市光谷高新技术开发区光谷步行街4明德国际风情街8号楼3F');

-- --------------------------------------------------------

--
-- 表的结构 `tickets`
--

DROP TABLE IF EXISTS `tickets`;
CREATE TABLE IF NOT EXISTS `tickets` (
  `U_ID` int(11) NOT NULL,
  `S_ID` int(11) NOT NULL,
  PRIMARY KEY (`U_ID`,`S_ID`) USING BTREE,
  KEY `S_ID` (`S_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk COMMENT='用户订票表';

--
-- 转存表中的数据 `tickets`
--

INSERT INTO `tickets` (`U_ID`, `S_ID`) VALUES
(1, 6),
(1, 11);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `topfilms`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `topfilms`;
CREATE TABLE IF NOT EXISTS `topfilms` (
`F_ID` int(11)
,`F_name_zh` char(40)
,`F_name_en` varchar(40)
,`F_grade` tinyint(4)
,`F_img_url` varchar(100)
);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `toppeople`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `toppeople`;
CREATE TABLE IF NOT EXISTS `toppeople` (
`P_ID` int(11)
,`P_name_zh` char(40)
,`P_name_en` char(20)
,`P_img_url` varchar(100)
,`P_count` int(10) unsigned
);

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `U_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `U_name` char(20) COLLATE gbk_bin NOT NULL COMMENT '用户名',
  `U_email` char(30) COLLATE gbk_bin NOT NULL COMMENT '邮箱',
  `U_password` char(16) COLLATE gbk_bin NOT NULL COMMENT '密码',
  `isAdmin` char(2) COLLATE gbk_bin NOT NULL DEFAULT '否' COMMENT '是否是管理员',
  PRIMARY KEY (`U_ID`) USING BTREE COMMENT='User''s id'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=gbk COLLATE=gbk_bin COMMENT='用户表';

--
-- 转存表中的数据 `users`
--

INSERT INTO `users` (`U_ID`, `U_name`, `U_email`, `U_password`, `isAdmin`) VALUES
(1, 'larry', '709603507@qq.com', '2333', '是'),
(2, '1234567@qq.com', '1234567@qq.com', '2333', '否'),
(3, 'test@qq.com', 'test@qq.com', 'test', '否');

-- --------------------------------------------------------

--
-- 视图结构 `topfilms`
--
DROP TABLE IF EXISTS `topfilms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`mymtime`@`%` SQL SECURITY DEFINER VIEW `topfilms`  AS  select `films`.`F_ID` AS `F_ID`,`films`.`F_name_zh` AS `F_name_zh`,`films`.`F_name_en` AS `F_name_en`,`films`.`F_grade` AS `F_grade`,`films`.`F_img_url` AS `F_img_url` from `films` order by `films`.`F_grade` desc limit 0,10 ;

-- --------------------------------------------------------

--
-- 视图结构 `toppeople`
--
DROP TABLE IF EXISTS `toppeople`;

CREATE ALGORITHM=UNDEFINED DEFINER=`mymtime`@`%` SQL SECURITY DEFINER VIEW `toppeople`  AS  select `people`.`P_ID` AS `P_ID`,`people`.`P_name_zh` AS `P_name_zh`,`people`.`P_name_en` AS `P_name_en`,`people`.`P_img_url` AS `P_img_url`,`people`.`P_count` AS `P_count` from `people` order by `people`.`P_count` desc limit 0,10 ;

--
-- 限制导出的表
--

--
-- 限制表 `actin`
--
ALTER TABLE `actin`
  ADD CONSTRAINT `actin_ibfk_1` FOREIGN KEY (`F_ID`) REFERENCES `films` (`F_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `actin_ibfk_2` FOREIGN KEY (`P_ID`) REFERENCES `people` (`P_ID`) ON UPDATE CASCADE;

--
-- 限制表 `favoritemovie`
--
ALTER TABLE `favoritemovie`
  ADD CONSTRAINT `favoritemovie_ibfk_1` FOREIGN KEY (`F_ID`) REFERENCES `films` (`F_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `favoritemovie_ibfk_2` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`) ON UPDATE CASCADE;

--
-- 限制表 `favoritepeople`
--
ALTER TABLE `favoritepeople`
  ADD CONSTRAINT `favoritepeople_ibfk_1` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`),
  ADD CONSTRAINT `favoritepeople_ibfk_2` FOREIGN KEY (`P_ID`) REFERENCES `people` (`P_ID`);

--
-- 限制表 `films`
--
ALTER TABLE `films`
  ADD CONSTRAINT `films_ibfk_1` FOREIGN KEY (`F_directorID`) REFERENCES `people` (`P_ID`) ON UPDATE CASCADE;

--
-- 限制表 `show`
--
ALTER TABLE `show`
  ADD CONSTRAINT `show_ibfk_1` FOREIGN KEY (`F_ID`) REFERENCES `films` (`F_ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `show_ibfk_2` FOREIGN KEY (`T_ID`) REFERENCES `theaters` (`T_ID`) ON UPDATE CASCADE;

--
-- 限制表 `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`S_ID`) REFERENCES `show` (`S_ID`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`U_ID`) REFERENCES `users` (`U_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
