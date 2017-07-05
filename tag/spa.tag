<spa>
    <google-drive if="{ cloud }"></google-drive>
    <div class="pure-g" if="{ viewForm }">
        <vertex-form class="pure-u-1"></vertex-form>
    </div>
    <vertex-list></vertex-list>
    <script>
        var self = this
        this.viewForm = false
        this.cloud = false

        // this to hide waiting spinner
        this.on('mount', function () {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })

    </script>
</spa>