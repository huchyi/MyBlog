/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */
//
// CKEDITOR.editorConfig = function( config ) {
// 	// Define changes to default configuration here. For example:
// 	// config.language = 'fr';
// 	// config.uiColor = '#AADC6E';
// };

CKEDITOR.editorConfig = function( config ) {
    config.toolbarGroups = [
        { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
        { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
        { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
        { name: 'forms', groups: [ 'forms' ] },
        '/',
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
        { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
        { name: 'links', groups: [ 'links' ] },
        { name: 'insert', groups: [ 'insert' ] },
        '/',
        { name: 'styles', groups: [ 'styles' ] },
        { name: 'colors', groups: [ 'colors' ] },
        { name: 'tools', groups: [ 'tools' ] },
        { name: 'others', groups: [ 'others' ] },
        { name: 'about', groups: [ 'about' ] }
    ];
};

// 在 CKEditor 中集成 CKFinder，注意 ckfinder 的路径选择要正确。
// CKFinder.SetupCKEditor(null, '/ckfinder/');
// config.filebrowserBrowseUrl = 'kcfinder/browse.php?type=files';
// config.filebrowserImageBrowseUrl = 'kcfinder/browse.php?type=images';
// config.filebrowserFlashBrowseUrl = 'kcfinder/browse.php?type=flash';
// config.filebrowserUploadUrl = 'kcfinder/upload.php?type=files';
config.filebrowserImageUploadUrl = '/MyBlog/file/doUpload3';
// config.filebrowserFlashUploadUrl = 'kcfinder/upload.php?type=flash';