//<?php
/**
 * pb_addcomment
 *
 * Comment saving prepare for FormLister
 *
 * @category	snippet
 * @internal	@modx_category Comments
 * @internal	@installset base
 * @internal	@overwrite true
 * @internal	@properties 
 */

	
// Function to get the client IP address
if (!function_exists('get_comment_ip')){
	function get_comment_ip() {
		$ipaddress = '';
		if (getenv('HTTP_CLIENT_IP'))
			$ipaddress = getenv('HTTP_CLIENT_IP');
		else if(getenv('HTTP_X_FORWARDED_FOR'))
			$ipaddress = getenv('HTTP_X_FORWARDED_FOR');
		else if(getenv('HTTP_X_FORWARDED'))
			$ipaddress = getenv('HTTP_X_FORWARDED');
		else if(getenv('HTTP_FORWARDED_FOR'))
			$ipaddress = getenv('HTTP_FORWARDED_FOR');
		else if(getenv('HTTP_FORWARDED'))
		   $ipaddress = getenv('HTTP_FORWARDED');
		else if(getenv('REMOTE_ADDR'))
			$ipaddress = getenv('REMOTE_ADDR');
		else
			$ipaddress = 'UNKNOWN';
		return $ipaddress;
	}
}

if ($FormLister->isSubmitted())
{	
	date_default_timezone_set('Europe/Moscow');
	
	$params = $FormLister->config->getConfig();
	
	//docId
	if ($params['docId']) $docId = $params['docId'];
	else $docId = $modx->documentIdentifier;
	
	if ($params['commentBlock']) $commentBlock = $params['commentBlock'];
	else $commentBlock = 'comment';
	
	if ($params['container']) $container = $params['container'];
	else $container = 'comments';
	
	//publish by default
	if ($params['visible']) $visible = $params['visible'];
	else $visible=0;
	
	//prepare form values
	$fields = array(
		'name' => $FormLister->getField('name'),
		'phoneoremail' => $FormLister->getField('phoneoremail'),
		'comment' => $FormLister->getField('comment'),
		'date'=> date('d-m-Y H:i:00'),
		'ip'=>get_comment_ip(),
	);
	
	//table name
	$table = $modx->getFullTableName('pagebuilder');
	
	//get comment index
	$index = $modx->db->getValue($modx->db->select("max(`index`)+1", $table, "document_id='" . $docId ."' AND container='" . $container ."'"));
	if(!$index) $index = 0;
	
	
	$fields = array(
		'document_id' => $docId,
        'config' => $commentBlock,
		'container'=> $container,
        'values' => json_encode($fields, JSON_UNESCAPED_UNICODE),
		'visible'=> $visible,
		'index'=> $index,
		'title'=>''
    ); 
    $modx->db->insert($fields, $table); 
}
