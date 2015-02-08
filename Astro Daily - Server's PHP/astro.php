<?php
error_reporting(0);
date_default_timezone_set('Asia/Hong_Kong');
include_once('lib.simple_html_dom.php');

function check_in_range($start_date, $end_date, $date_from_user){
	// Convert to timestamp
	$start_ts = strtotime($start_date);
	$end_ts = strtotime($end_date);
	$user_ts = strtotime($date_from_user);

	// Check that user date is between start & end
	return (($user_ts >= $start_ts) && ($user_ts <= $end_ts));
}

$name = $_GET['name'];
$birthday = $_GET['birthday'];
$type = $_GET['type'];
sscanf($birthday, "%d-%d-%d", $year, $month, $day);

if($type != "day_json"){
?>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width">
<style>
h1#title{
	text-align: center;
	background-color: rgba(159, 247, 129, 0.5);
	padding: 25px;
	font-size: 180%;
	color: red;
}
p{
	text-indent: 2em;
	font-size: 130%;
}
.red{
	color: red;
}
</style>
</head>
<body>
<?php
}

/*
switch (check_user_constellation($year, $month, $day)){
	case "aquarius":
		echo "水瓶";
		
	break;
	case "capricorn":
		echo "跨年!";
	break;
}
*/

function check_user_constellation($year, $month, $day){
	$user_birthday = $year.'-'.$month.'-'.$day;
	if(check_in_range($year."-1-20", $year."-2-19", $user_birthday)){
		//return "aquarius";	//水瓶座
		return "10";
	}
	if(check_in_range($year."-2-20", $year."-3-20", $user_birthday)){
		//return "pisces";	//雙魚座
		return "11";
	}
	if(check_in_range($year."-3-21", $year."-4-20", $user_birthday)){
		//return "aries";		//牡羊座
		return "0";
	}
	if(check_in_range($year."-4-21", $year."-5-20", $user_birthday)){
		//return "taurus";	//金牛座
		return "1";
	}
	if(check_in_range($year."-5-21", $year."-6-21", $user_birthday)){
		//return "gemini";	//雙子座
		return "2";
	}
	if(check_in_range($year."-6-22", $year."-7-22", $user_birthday)){
		//return "cancer";	//巨蟹座
		return "3";
	}
	if(check_in_range($year."-7-23", $year."-8-22", $user_birthday)){
		//return "leo";		//獅子座
		return "4";
	}
	if(check_in_range($year."-8-23", $year."-9-22", $user_birthday)){
		//return "virgo";		//處女座
		return "5";
	}
	if(check_in_range($year."-9-23", $year."-10-22", $user_birthday)){
		//return "libra";		//天秤座
		return "6";
	}
	if(check_in_range($year."-10-23", $year."-11-21", $user_birthday)){
		//return "scorpio";	//天蠍座
		return "7";
	}
	if(check_in_range($year."-11-22", $year."-12-21", $user_birthday)){
		//return "sagittarius";	//射手座
		return "8";
	}
	if(
		check_in_range($year."-12-22", ($year+1)."-1-19", $user_birthday) ||
		check_in_range(($year-1)."-12-22", $year."-1-19", $user_birthday)
	){
		//return "capricorn";	//魔羯座
		return "9";
	}
}

switch (check_user_constellation($year, $month, $day)){
	case "10":
		$constellation_name = "水瓶座";
	break;
	case "11":
		$constellation_name = "双鱼座";
	break;
	case "0":
		$constellation_name = "牡羊座";
	break;
	case "1":
		$constellation_name = "金牛座";
	break;
	case "2":
		$constellation_name = "双子座";
	break;
	case "3":
		$constellation_name = "巨蟹座";
	break;
	case "4":
		$constellation_name = "狮子座";
	break;
	case "5":
		$constellation_name = "处女座";
	break;
	case "6":
		$constellation_name = "天秤座";
	break;
	case "7":
		$constellation_name = "天蝎座";
	break;
	case "8":
		$constellation_name = "射手座";
	break;
	case "9":
		$constellation_name = "魔羯座";
	break;
}


$Hour = date('G');
if ( $Hour >= 5 && $Hour <= 11 ) {
    $dayTerm = "早安";
} else if ( $Hour >= 12 && $Hour <= 18 ) {
    $dayTerm = "午安";
} else if ( $Hour >= 19 || $Hours <= 4 ) {
    $dayTerm = "晚安";
}

?>
<?php if($type != "day_json"){ ?><h1 id="title"><?php echo $dayTerm; ?>，<?php echo $constellation_name; ?>的<?php echo $name; ?>！ ^_^</h1><?php } ?>
<?php
if($type == "day"){
	$astro_result = file_get_contents('http://api.uihoo.com/astro/astro.http.php?fun=day&id='.check_user_constellation($year, $month, $day).'&format=json');

	$astro = json_decode($astro_result, true);

?>
<p style="color: #848484;">日期：<?php echo $astro[11]; ?></p>
<p><?php echo $dayTerm; ?>，出生于<?php echo $year; ?>年<?php echo $month; ?>月<?php echo $day; ?>日的<?php echo $name; ?>！希望您可以有美好、美满、美妙的一天！以下你今天的运势：</p>
<p><?php echo $astro[9]["value"];	//综合概述 ?></p>
<p>总的来说，您今天的：</p>
<?php for($x=0; $x<=3; ++$x){ ?>
<p><?php echo $astro[$x]["title"]; ?>：<span class="red"><?php echo str_repeat("&#9733", $astro[$x]["rank"]); ?><?php echo str_repeat("&#9734", 5-$astro[$x]["rank"]); ?></span></p>
<?php } ?>
<?php for($x=4; $x<=5; ++$x){ ?>
<p><?php echo $astro[$x]["title"]; ?>：<span class="red"><?php echo $astro[$x]["value"]; ?>/100</span></p>
<?php } ?>
<?php for($x=6; $x<=8; ++$x){ ?>
<p><?php echo $astro[$x]["title"]; ?>：<span class="red"><?php echo $astro[$x]["value"]; ?></span></p>
<?php } ?>
<p style="font-size: 100%; color: #848484; text-align: center; text-indent: 0;">以上信息来自于：<a href="http://api.uihoo.com/demo/astro_day.shtml" style="pointer-events: none;">星座运势API</a></p>
<?php
}else if($type == "week"){
	$astro_result = file_get_contents('http://api.uihoo.com/astro/astro.http.php?fun=week&id='.check_user_constellation($year, $month, $day).'&format=json');

	$astro = json_decode($astro_result, true);
?>
<p style="color: #848484;">日期：</p>
<p style="color: #848484;"><?php echo $astro[9][0]; ?> 至 <?php echo $astro[9][1]; ?></p>
<p><?php echo $dayTerm; ?>，出生于<?php echo $year; ?>年<?php echo $month; ?>月<?php echo $day; ?>日的<?php echo $name; ?>！希望您可以有开心、愉快、幸福的一周！以下你本周的运势：</p>
<p><?php echo $astro[0]["title"]; ?>：<span class="red"><?php echo str_repeat("&#9733", $astro[0]["rank"]); ?><?php echo str_repeat("&#9734", 5-$astro[0]["rank"]); ?></span></p>
<p><?php echo $astro[0]["value"]; ?></p>
<p><?php echo $astro[1]["title"]; ?></p>
<?php for($x=0; $x<=1; ++$x){ ?>
<p><?php echo $astro[1]["title2"][$x]; ?> <span class="red"><?php echo str_repeat("&#9733", $astro[1]["rank"][$x]); ?><?php echo str_repeat("&#9734", 5-$astro[1]["rank"][$x]); ?></p>
<p><?php echo $astro[1]["value2"][$x]; ?></p>
<?php } ?>
<?php for($x=2; $x<=4; ++$x){ ?>
<p><?php echo $astro[$x]["title"]; ?>：<span class="red"><?php echo str_repeat("&#9733", $astro[$x]["rank"]); ?><?php echo str_repeat("&#9734", 5-$astro[$x]["rank"]); ?></span></p>
<p><?php echo $astro[$x]["value"]; ?></p>
<?php } ?>
<?php for($x=5; $x<=7; ++$x){ ?>
<p><?php echo $astro[$x]["title"]; ?>：</p>
<p><?php echo $astro[$x]["value"]; ?></p>
<?php } ?>
<p style="font-size: 100%; color: #848484; text-align: center; text-indent: 0;">以上信息来自于：<a href="http://api.uihoo.com/demo/astro_day.shtml" style="pointer-events: none;">星座运势API</a></p>

<?php
}else if($type == "disposition"){
	?>
<style>
h2{
	text-align: center;
	font-size: 150%;
}
p{
	text-indent: 2em;
	font-size: 130%;
}
</style>
	<?php
	include_once check_user_constellation($year, $month, $day).".php";
	?>
<div style="color: #848484; text-align: center;">
	<p style="font-size: 100%; text-indent: 0;">以上信息均来源于网络</p>
	<p style="font-size: 100%; text-indent: 0;">也请阅读程序附注部分关于“巴纳姆效应”的说明！</p>
</div>
<?php
}else if($type == "barnum"){
	include_once "barnum.php";
}else if($type == "day_json"){
	$astro_result = file_get_contents('http://api.uihoo.com/astro/astro.http.php?fun=day&id='.check_user_constellation($year, $month, $day).'&format=json');

	$astro = json_decode($astro_result, true);
	?>
{"today": {"today_info": "<?php echo str_replace(array("\r", "\n"), "", $astro[9]["value"]); ?>", "today_info_substr": "<?php echo mb_substr($astro[9]["value"], 0, 30, "UTF-8"); ?>..."}}
	<?php
}

if($type != "day_json"){
?>
</body>
</html>
<?php } ?>