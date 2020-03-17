/**
 * pb_commentsform
 *
 * Comments form
 *
 * @category	chunk
 * @internal	@modx_category Comments
 * @internal	@installset base
 * @internal	@overwrite true
 */
[!FormLister?
&formTpl=`@CODE:<form action="[~[*id*]~]" class="mb-5" method="post">
	<h3>Add comment</h3>
	<div class="form-group">
		<label for="name">Your name *</label>
		<input type="text" class="form-control [+name.errorClass+]" id="name" name="name" required="required">
		[+name.error+]
	</div>
	<div class="form-group">
		<label for="phoneoremail">Your phone or e-mail *</label>
		<input type="text" class="form-control [+phoneoremail.errorClass+]" id="phoneoremail" name="phoneoremail" aria-describedby="emailHelp" required="required">
		[+phoneoremail.error+]
		<small id="emailHelp" class="form-text text-muted">We'll never share your email or phone with anyone else.</small>
	</div>
	<div class="form-group">
		<label for="comment">Share your thoughts *</label>
		<textarea class="form-control [+comment.errorClass+]" id="comment" name="comment" cols="30" rows="5" required="required">[+comment.value+]</textarea>
		[+comment.error+]
	</div>
	<div class="form-group form-check">
		<input type="checkbox" class="form-check-input" id="sogl" name="sogl" checked="checked">
		<label class="form-check-label" for="sogl">I agree with privacy policy</label>
	</div>
	<button type="submit" class="btn btn-primary">Submit</button>
	<input type="hidden" name="formid" value="commentform">
	<input type="hidden" name="link" value="[(site_url)][~[*id*]~]">
</form>
`
&subject=`Comment on the: [(site_name)] - [*pagetitle*]`
	&protectSubmit=`0`
	&submitLimit=`5`
	&formid=`commentform`
	&rules=`{
		"name":{"required":"Name is required"},
		"phoneoremail":{"required":"Phone or e-mail is required"},
		"comment":{"required":"Your comment must be non-empty"},
		"sogl":{"required":"You should agree with privacy policy"}
	}`
	&to=`some@mail.net`
	&reportTpl=`@CODE: 
		<p>A new comment on the «[*pagetitle*]» page has been added to «[(site_name)]»<b></b></p>
		<p><b>Name:</b> [+name+]</p>
		<p><b>Phone or e-mail:</b> [+phoneoremail+]</p>
		<h4>Comment text</h4>
		<p>[+comment+]</p>
		<p><b>Sent from page:</b> [+title+] — [+link+]</p>
		<p>To approve or edit a comment, log in to the control panel</p>`
	&successTpl=`@CODE: <h3>Success!</h3><p>Your comment has been successfully added. Please wait for administrator to verify it.</p>`
	&errorClass=`is-invalid`
	&requiredClass=`is-invalid`
	&messagesTpl=`@CODE: <div class="invalid-feedback">[+messages+]</div>`
	&visible=`0`
	&container=`comments`
	&commentBlock=`comment`
	&prepareAfterProcess=`pb_addcomment`
!]
