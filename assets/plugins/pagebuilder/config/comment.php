<?php

    return [
        'title' => 'Comment',
        'image' => 'assets/plugins/pagebuilder/images/text.jpg',
        'container' => 'comments',
        'templates' => [
            'owner' => '
                <div class="card mb-2">
					<div class="card-header">
						<b>[+name+]</b> <small class="text-muted">on [+date+]</small>
					</div>
                    <div class="card-body">
						[+comment+]
						[[if? &is=`[+answer+]|not_empty` &separator=`|` &then=`<blockquote class="mt-3 mb-0"><h6 class="text-muted">Admin reply</h6>[+answer+]</blockquote>`]]
					</div>
                </div>
            ',
        ],

        'fields' => [
			'name'=>[
				'caption'=>'Name',
				'type'=>'text'
			],
			'phoneoremail'=>[
				'caption'=>'Phone or e-mail',
				'type'=>'text'
			],
			'comment'=>[
				'caption'=>'Comment',
				'type'=>'textarea'
			],
            'ip' => [
                'caption'=>'IP Adress',
				'type'=>'text'
            ],
			'date' => [
                'caption'=>'Date added',
				'type'=>'date'
            ],
			'answer'=>[
				'caption'=>'Answer',
				'type'=>'textarea'
			]
        ],
    ];

