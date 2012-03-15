    CKEDITOR.plugins.add('insertTag',
    {
        init: function (editor) {
            var pluginName = 'insertTag';
            editor.ui.addButton('insertTag',
                {
                    label: 'Insert a Tag',
                    command: 'insertTag',
                    icon: '/images/fam/tag.png'
                });
            var cmd = editor.addCommand('insertTag', { exec: showMyDialog });
        }
    });
  
