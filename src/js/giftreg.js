// based on http://alittlecode.com/files/jQuery-Validate-Demo/

function validate_highlight(element) {
	$(element).addClass('is-invalid').removeClass('is-valid');
}

function validate_success(label) {
	$(label).removeClass('invalid-feedback').closest('.mb-3').find(':input').removeClass('is-invalid').addClass('is-valid');
}
