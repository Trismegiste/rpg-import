<google-drive>
    <div class="pure-g">
        <div class="pure-u-1 pure-u-md-1-2 pure-u-xl-1-4">
            <google-drive-repo-save></google-drive-repo-save>
        </div>
        <div class="pure-u-1 pure-u-md-1-2 pure-u-xl-1-4">
            <google-drive-repo-load></google-drive-repo-load>
        </div>
        <div class="pure-u-1 pure-u-md-1-2 pure-u-xl-1-4">
            <google-drive-doc-save></google-drive-doc-save>
        </div>
    </div>
    <script>
        var self = this

        this.on('toggle-cloud', function () {
            self.parent.trigger('toggle-cloud')
        })
    </script>
</google-drive>