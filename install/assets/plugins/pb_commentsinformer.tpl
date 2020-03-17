//<?php
/**
 * pb_commentsinformer
 *
 * <b>0.1</b> Welcome Page comments informer
 *
 * @category    plugin
 * @internal    @events OnManagerWelcomeHome
 * @internal    @modx_category Comments
 * @internal    @properties &plugintitle=Plugin title;text;Last Comments &empty=«No new comments» text;text;No new comments &list=«New comments» text;text;New comments in documents: &container=Container;text;comments
 * @internal    @disabled 0
 * @internal    @installset base
 */
$output = "";
$e = &$modx->Event;
switch($e->name){
	case 'OnManagerWelcomeHome':
		
		$plugin_title = $e->params['plugintitle'];
		
		$output='';
		$res = $modx->db->select("id,document_id", $modx->getFullTableName('pagebuilder'), "container='" . $e->params['container'] ."' AND visible='0' group by document_id");
		
		$documents = $modx->db->makeArray( $res );
		if($documents){
			$output.='<p>'.$e->params['list'].'</p><ul>';
			foreach($documents as $doc){
				$title = $modx->runsnippet('DocInfo',['docid'=>$doc['document_id'] ]);
				$output.='<li><a href="?a=27&r=1&id='.$doc['document_id'].'">'.$title.'</a></li>';
			}
			$output.='</ul>';
		}else{
			$output=$e->params['empty'];
		}
		
		if (!empty($output)){
			$widgets['lastcomments'] = array(
				'menuindex' =>'1',
				'id' => 'pb_commentsinformer',
				'cols' => 'col-sm-12',
				'icon' => 'fas fa-comment',
				'title' => $plugin_title,
				'body' => '<div class="card-body">'.$output.'</div>',
				'hide'=>'0'
			);
			$e->output(serialize($widgets));
		}
		break;
}
