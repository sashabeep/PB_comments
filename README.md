# PB_comments
**Evolition CMS comments**

Yet another simple comments solution based on **PageBuilder** and **FormLister**

Package provides:

1. Template Variable "comments" with buil-in configs for PageBuilder
2. Chunk to display comments list (**pb_commentslist**)
3. Simple comment form (**pb_commentsform**)
4. Simple informer plugin on manager welcome page that indicates documents with new comments

## Installation
1. Download as zip archive and install via extras module from zip file
2. Assign Template Variable "comments" to desired template
3. Put the chunks **{{pb_commentslist}}** and **{{pb_commentsform}}** in the template source
4. Change ```&to=``` parameter in ForLister call in **{{pb_commentsform}}** to your e-mail

##Requirements

- [PageBuilder](https://github.com/mnoskov/pagebuilder)
- [FormLister](https://github.com/Pathologic/FormLister)

Both can be installed via Extras module from admin panel without extra downloads.

##Additional usage
By default all the comments posted to PageBuilder invisible. If you want to publish by default add ```&visible=`1` ``` in FormLister call in **{{pb_commentsform}}**

By default comments shown as in the admin panel. Thus, newer comments will be in the end of list. To reverse them (new on top) there is no option for PageBuilder call. But you can list comments reversed (or unstyled) using Blade

```php
@php
	$comments = $modx->runSnippet('PageBuilder', ['renderTo' => 'array','container'=>'comments'],0,'comments')[0];
	$comments_rev = array_reverse($comments);
@endphp
@foreach ($comments_rev as $item)
	<div class="comment">
		{{ $item['name'] }}
		{{ $item['comment'] }}
		{{ $item['date'] }}
		@if($item['answer'])
			Admin reply: {{ $item['answer'] }}
		@endif
	</div>
@endforeach
```

###Use in ajax forms (or as a feedback collection)
Provide the ```&docId=`N` ``` parameter in FormLister call in **{{pb_commentsform}}** to post comments to particular page

### Strange things with Date Added?
Try to specify the timezone (or comment the line) in snippet [pb_addcomment](https://github.com/sashabeep/PB_comments/blob/4e98daa6d2a8170c33401339378d1db3f6d2d824/install/assets/snippets/pb_addcomment.tpl#L39)

By default, Date format for "Date Added" is specified in https://github.com/sashabeep/PB_comments/blob/4e98daa6d2a8170c33401339378d1db3f6d2d824/install/assets/snippets/pb_addcomment.tpl#L62

If you are using other format in **[(datetime_format)]** system setting than dd-mm-YYYY

You should replace [the line](https://github.com/sashabeep/PB_comments/blob/4e98daa6d2a8170c33401339378d1db3f6d2d824/install/assets/snippets/pb_addcomment.tpl#L62) with
```php
/* for mm/dd/YYYY */
'date'=> date('m/d/Y H:i:00'),

/* for YYYY/mm/dd */
'date'=> date('Y/m/d H:i:00'),
```
